class_name Projectile
extends CharacterBody2D

# Put in logic to move projectile right for certain range and do certain damage on collision with enemy
var reach:float
var damage:float

#Bool to determine if should start firing
var fire:bool = true
var range_timer:Timer

func _ready() -> void:
	#Timer for shoot time
	range_timer = Timer.new()
	range_timer.one_shot = true
	add_child(range_timer)
	range_timer.start(reach)

func _physics_process(delta: float) -> void:
	# Sets initial velocity of projectile
	move_and_collide(Vector2(1000, 0) * delta)
	if range_timer.is_stopped():
		queue_free()


# Signal for if projectile hits an enemy (calls enemy to take damage, frees projectile)
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Enemy:
		#print("enemy hit")
		# This signal is for sound manager later
		#signals.enemy_damaged.emit(damage)
		body.take_damage(damage)
		queue_free()
