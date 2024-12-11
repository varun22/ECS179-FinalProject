class_name TurretType
extends Node

# 3 different types of turrets plus a basic one for the start of the game (can chage later)
enum Type {
	BASIC,
	POWER,
	FREQUENCY,
	REACH,
}

# Array to keep track of type of each turret and stats of each turret
var type_array = [Type.BASIC, Type.BASIC, Type.BASIC, Type.BASIC, Type.BASIC]
var reach_array = [50.0, 50.0, 50.0, 50.0, 50.0]
var damage_array = [10.0, 10.0, 10.0, 10.0, 10.0]
var frequency_array = [4.0, 4.0, 4.0, 4.0, 4.0]
