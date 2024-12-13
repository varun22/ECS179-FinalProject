class_name TurretFactory
extends Node

@export var turret:PackedScene

# Stores base values for turrets
var base_reach:float = 0.6
var base_damage:float = 5.0
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
			new_turret.damage = base_damage + (5.0 * (turretType.power_level[i] - 1))
			new_turret.frequency = base_frequency
			new_turret.type = turretType.Type.POWER
		elif turretType.type_array[i] == turretType.Type.REACH:
			new_turret.reach = base_reach + (0.05 * (turretType.reach_level[i] - 1))
			new_turret.damage = base_damage
			new_turret.frequency = base_frequency
			new_turret.type = turretType.Type.REACH
		elif turretType.type_array[i] == turretType.Type.FREQUENCY:
			new_turret.reach = base_reach
			new_turret.damage = base_damage
			new_turret.frequency = base_frequency - (0.1 * (turretType.frequency_level[i] - 1))
			if new_turret.frequency < 0.5:
				new_turret.frequency = 0.5
			new_turret.type = turretType.Type.FREQUENCY
		# Place turrets in correct position based on turret number
		if i == 0:
			new_turret.position.x = 425
			new_turret.position.y = 545
			new_turret.lane = 1
		elif i == 1:
			new_turret.position.x = 345
			new_turret.position.y = 665
			new_turret.lane = 2
		elif i == 2:
			new_turret.position.x = 265
			new_turret.position.y = 785
			new_turret.lane = 3
		elif i == 3:
			new_turret.position.x = 185
			new_turret.position.y = 905
			new_turret.lane = 4
		elif i == 4:
			new_turret.position.x = 105
			new_turret.position.y = 1025
			new_turret.lane = 5
		$".".add_child(new_turret)
