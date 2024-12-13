class_name Enemy
extends CharacterBody2D

signal died(value: int)

# Variables attributed to enemy (these variables don't do anything since they get overwritten in waves_manager)
@export var damage: float = 10
@export var speed: float = 100
@export var health: float = 100
# Type of enemy, 1, 2, or 3
var type: int

var is_attacking: bool = false
var attack_cooldown: float = 1.0 # Time between attacks
var time_since_last_attack: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HealthBar.max_value = health
	$HealthBar.value = health
	$Sprite2D/AnimationPlayer.animation_finished.connect(_on_animation_finished)
	if type == 1:
		$Sprite2D/AnimationPlayer.play("saber_move_left")
	elif type == 2:
		$Sprite2D/AnimationPlayer.play("cloak_move_left")
	else:
		$Sprite2D/AnimationPlayer.play("machete_move_left")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_attacking:
		self.global_position.x -= speed * delta

	time_since_last_attack += delta

	if self.global_position.x < 10:
		_enemy_died()
		queue_free()

func _enemy_died() -> void:
	#print("Enemy has died")
	# Increment UI
	if type == 1:
		$Sprite2D/AnimationPlayer.play("saber_death")
	elif type == 2:
		$Sprite2D/AnimationPlayer.play("cloak_death")
	else:
		$Sprite2D/AnimationPlayer.play("machete_death")
	died.emit(100)
	if type == 1:
		globalVars.currency += 10.0
	elif type == 2:
		globalVars.currency += 20.0
	elif type == 3:
		globalVars.currency += 30.0

# Function for when enemies take damage from a projectile
func take_damage(damage_amt: float) -> void:
	health -= damage_amt
	$HealthBar.value = health
	#print(health)
	if health <= 0:
		_enemy_died()
		queue_free()

# Function for when the enemy collides with another entity
func _on_HitBox_area_entered(area: Area2D) -> void:
	if area is HurtBox:
		var hurtbox = area as HurtBox
		if not is_attacking and time_since_last_attack >= attack_cooldown:
			attack(hurtbox)

func attack(target: HurtBox) -> void:
	is_attacking = true
	time_since_last_attack = 0.0
	if type == 1:
		$Sprite2D/AnimationPlayer.play("saber_attack")
	elif type == 2:
		$Sprite2D/AnimationPlayer.play("cloak_attack")
	else:
		$Sprite2D/AnimationPlayer.play("machete_attack")
	
	if target.owner.has_method("take_damage"):
		target.owner.take_damage(damage)

# Callback for when the attack animation finishes
func _on_animation_finished(anim_name: String) -> void:
	if !$Sprite2D/AnimationPlayer.is_playing():
		is_attacking = false
