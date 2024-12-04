class_name TurretSpec
extends Node

# Placeholder for 9 different types of turrets (different sprites and base values)
enum Type {
	TYPE1,
	TYPE2,
	TYPE3,
	TYPE4,
	TYPE5,
	TYPE6,
	TYPE7,
	TYPE8,
	TYPE9,
}

var range:float
var damage:float
var frequency:float
var type:Type
