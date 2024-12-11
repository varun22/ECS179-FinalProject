class_name Projectile
extends CharacterBody2D

# Put in logic to move projectile right for certain range and do certain damage on collision with enemy
var reach:float
var damage:float

#Bool to determine if should start firing
var fire:bool = true

func _physics_process(delta: float) -> void:
	#var collision = move_and_collide(Vector2(100, 0) * delta)
	move_and_collide(Vector2(100, 0) * delta)
	#if collision:
		#print("enemy hit")
		#signals.enemy_damaged.emit(damage)
		#queue_free()
		
#func _ready() -> void:
	#set_contact_monitor(true)
	#set_max_contacts_reported(4)
		

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Enemy:
		print("enemy hit")
		#signals.enemy_damaged.emit(damage, body as Enemy)
		body.take_damage(damage)
		queue_free()
