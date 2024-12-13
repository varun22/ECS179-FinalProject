class_name Enemy
extends CharacterBody2D

signal died(value: int)

# Variables attributed to enemy (these variables don't do anything since they get overwritten in waves_manager)
@export var damage:float = 10
@export var speed:float = 100
@export var health:float = 100
# Type of enemy, 1, 2, or 3
var type:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HealthBar.max_value = health
	$HealthBar.value = health
	if type == 1:
		$Sprite2D/AnimationPlayer.play("saber_move_left")
	elif type == 2:
		$Sprite2D/AnimationPlayer.play("cloak_move_left")
	else:
		$Sprite2D/AnimationPlayer.play("machete_move_left")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.global_position.x -= speed * delta
	#print(speed * delta)
	if self.global_position.x < 10:
		#print("Enemy has made reach the end")
		#Delete this later! This is just for testing UI
		_enemy_died()
		queue_free()
		
func _enemy_died() -> void:
	# Play the appropriate death animation
	if type == 1:
		$Sprite2D/AnimationPlayer.play("saber_death")
	elif type == 2:
		$Sprite2D/AnimationPlayer.play("cloak_death")
	else:
		$Sprite2D/AnimationPlayer.play("machete_death")

	# Emit the died signal
	died.emit(100)

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
		queue_free()

		
