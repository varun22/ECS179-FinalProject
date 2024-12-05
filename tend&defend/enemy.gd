class_name Enemy
extends CharacterBody2D

# Variables attributed to enemy (these variables don't do anything since they get overwritten in waves_manager)
@export var damage:float = 10
@export var speed:float = 100
@export var health:float = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.global_position.x -= speed * delta
	#print(speed * delta)
	if self.global_position.x < 10:
		queue_free()
		
