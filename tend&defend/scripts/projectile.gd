class_name Projectile
extends CharacterBody2D

# Put in logic to move projectile right for certain range and do certain damage on collision with enemy
var reach:float
var damage:float

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(Vector2(100, 0) * delta)
	if collision:
		print("enemy hit")
		signals.enemy_damaged.emit(damage)
		queue_free()
		
