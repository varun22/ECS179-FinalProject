class_name TurretFactory
extends Node

@export var turret:PackedScene

# Stores base values for turrets
var base_reach:float = 5.0
var base_damage:float = 10.0
var base_frequency:float = 5.0

# Builds and returns a turret
func build(turret_spec:TurretSpec) -> Turret:
	var new_turret = turret.instantiate() as Turret
	new_turret.reach = turret_spec.reach
	new_turret.damage = turret_spec.damage
	new_turret.frequency = turret_spec.frequency
	new_turret.type = turret_spec.type
	
	return new_turret

# Rebuilds all turrets with new specs from buy phase
func rebuild() -> void:
	for i in 5:
		var new_turret = turret.instantiate() as Turret
		# Create turret specs based on turret type and level
		if turretType.type_array[i] == turretType.Type.BASIC:
			new_turret.reach = base_reach
			new_turret.damage = base_damage
			new_turret.frequency = base_frequency
			new_turret.type = turretType.Type.BASIC
		elif turretType.type_array[i] == turretType.Type.POWER:
			new_turret.reach = base_reach
			new_turret.damage = base_damage + (10.0 * (turretType.power_level[i] - 1))
			new_turret.frequency = base_frequency
			new_turret.type = turretType.Type.POWER
		elif turretType.type_array[i] == turretType.Type.REACH:
			new_turret.reach = base_reach + (1.0 * (turretType.reach_level[i] - 1))
			new_turret.damage = base_damage
			new_turret.frequency = base_frequency
			new_turret.type = turretType.Type.REACH
		elif turretType.type_array[i] == turretType.Type.FREQUENCY:
			new_turret.reach = base_reach
			new_turret.damage = base_damage
			new_turret.frequency = base_frequency - (0.5 * (turretType.frequency_level[i] - 1))
			new_turret.type = turretType.Type.FREQUENCY
		# Place turrets in correct position based on turret number
		if i == 0:
			new_turret.position.x = 413
			new_turret.position.y = 566
		elif i == 1:
			new_turret.position.x = 330
			new_turret.position.y = 670
		elif i == 2:
			new_turret.position.x = 272
			new_turret.position.y = 770
		elif i == 3:
			new_turret.position.x = 189
			new_turret.position.y = 877
		elif i == 4:
			new_turret.position.x = 112
			new_turret.position.y = 992
		$".".add_child(new_turret)
