extends Node
class_name Game
#Created this script primarily for dealing with signal inputs accross the game

@export var ui: UI

func on_enemy_died(score_value: int) -> void:
	ui._on_score_increase(score_value)
	
