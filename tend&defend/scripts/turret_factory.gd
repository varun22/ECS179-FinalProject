class_name TurretFactory
extends Node

@export var turret:PackedScene

# Builds and returns a turret
func build(turret_spec:TurretSpec) -> Turret:
	var new_turret = turret.instantiate() as Turret
	new_turret.reach = turret_spec.reach
	new_turret.damage = turret_spec.damage
	new_turret.frequency = turret_spec.frequency
	new_turret.type = turret_spec.type
	
	return new_turret
