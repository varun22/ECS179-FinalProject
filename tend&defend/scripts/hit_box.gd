class_name HitBox
extends Area2D


@export var damage:int = 20

func _ready() -> void:
	damage = get_parent().damage
	
func _process(delta: float) -> void:
	damage = get_parent().damage
	
func _init() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(hurtbox:HurtBox) -> void:
	if hurtbox.get_owner().has_method("take_damage"):
		hurtbox.owner.take_damage(damage)
