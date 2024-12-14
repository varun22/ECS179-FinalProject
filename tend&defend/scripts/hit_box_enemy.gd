class_name HitBoxEnemy
extends Area2D


@export var damage:int = 20
var attacking:bool = false

func _ready() -> void:
	damage = get_parent().damage
	
func _process(delta: float) -> void:
	damage = get_parent().damage
	attacking = get_parent().attacking
	
	if has_overlapping_areas():
		get_parent().attack()
		await get_tree().create_timer(0.5).timeout
	elif not has_overlapping_areas():
		get_parent().speed = 100
	
func _init() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(hurtbox:HurtBox) -> void:
	#get_parent().attack()
	if hurtbox.get_owner().has_method("take_damage") and attacking:
		hurtbox.owner.take_damage(damage)
	if hurtbox.get_owner() is Turret:
		get_parent().speed = 0
