class_name Enemy
extends CharacterBody2D

signal died(value: int)

# Variables attributed to enemy (these variables don't do anything since they get overwritten in waves_manager)
@export var damage:float = 10
@export var speed:float = 100
@export var health:float = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	signals.enemy_damaged.connect(_on_enemy_damaged)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.global_position.x -= speed * delta
	#print(speed * delta)
	if self.global_position.x < 10:
		print("Enemy has made reach the end")
		#Delete this later! This is just for testing UI
		_enemy_died()
		
		queue_free()
		
func _enemy_died() -> void:
	print("Enemy has died")
	#Increment UI
	died.emit(100)
	
func _on_enemy_damaged(damage: float) -> void:
	health -= damage
	print(health)
	if health <= 0:
		died.emit(0)
		queue_free()
