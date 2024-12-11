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
var reach_level = [1, 1, 1, 1, 1]
var power_level = [1, 1, 1, 1, 1]
var frequency_level = [1, 1, 1, 1, 1]
