class_name Enemy
extends CharacterBody2D

signal died(value: int)

# Variables attributed to enemy (these variables don't do anything since they get overwritten in waves_manager)
@export var damage:float = 10
@export var speed:float = 100
@export var health:float = 100
# Type of enemy, 1, 2, or 3
var type:int
var attacking:bool = false
var dead:bool = false

var attack_timer: Timer
var at_turret:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$HitBox/CollisionShape2D.disabled = true
	$HealthBar.max_value = health
	$HealthBar.value = health
	if type == 1:
		$Sprite2D/AnimationPlayer.play("saber_move_left")
	elif type == 2:
		$Sprite2D/AnimationPlayer.play("cloak_move_left")
	else:
		$Sprite2D/AnimationPlayer.play("machete_move_left")
		
	attack_timer = Timer.new()
	attack_timer.one_shot = true
	add_child(attack_timer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not attacking and not dead and not at_turret:
		self.global_position.x -= speed * delta
		$HitBox/CollisionShape2D.disabled = false
		if type == 1:
			$Sprite2D/AnimationPlayer.play("saber_move_left")
		elif type == 2:
			$Sprite2D/AnimationPlayer.play("cloak_move_left")
		else:
			$Sprite2D/AnimationPlayer.play("machete_move_left")
	if at_turret:
		pass
	#print(speed * delta)
	if self.global_position.x < 0:
		#print("Enemy has made reach the end")
		#Delete this later! This is just for testing UI
		#_enemy_died()
		queue_free()
		
func _enemy_died() -> void:
	dead = true
	# Play the appropriate death animation
	if type == 1:
		$Sprite2D/AnimationPlayer.play("saber_death")
		# Emit the died signal
		died.emit(100)
	elif type == 2:
		$Sprite2D/AnimationPlayer.play("cloak_death")
		# Emit the died signal
		died.emit(200)
	else:
		$Sprite2D/AnimationPlayer.play("machete_death")
		# Emit the died signal
		died.emit(300)


	# FIX ME: Does not Spawn banana as it should
	var banana_scene = preload("res://scenes/banana.tscn") 
	var banana_instance = banana_scene.instantiate()
	banana_instance.global_position = self.global_position
	get_parent().add_child(banana_instance)

# Function for when enemies take damage form projectile
func take_damage(damage_amt: float) -> void:
	health -= damage_amt
	$HealthBar.value = health
	#print(health)
	if health <= 0:
		_enemy_died()
		await get_tree().create_timer(0.7).timeout
		queue_free()

func attack() -> void:
	if attack_timer.is_stopped():
		attacking = true
		attack_timer.start(1.0)
		if type == 1:
			$Sprite2D/AnimationPlayer.play("saber_attack")
		elif type == 2:
			$Sprite2D/AnimationPlayer.play("cloak_attack")
		elif type == 3:
			$Sprite2D/AnimationPlayer.play("machete_attack")
		await get_tree().create_timer(0.5).timeout
		attacking = false
