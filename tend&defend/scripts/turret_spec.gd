class_name TurretSpec
extends Node

# 3 different types of turrets plus a basic one for the start of the game (can chage later)
enum Type {
	BASIC,
	POWER,
	FREQUENCY,
	RANGE,
}

var range:float
var damage:float
var frequency:float
var type:Type
