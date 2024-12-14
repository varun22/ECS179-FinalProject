extends Node
class_name Game
#Created this script primarily for dealing with signal inputs accross the game

@export var ui: UI

func _ready() -> void:
	audioPlayer.play_stage1()

func on_enemy_died(score_value: int) -> void:
	ui._on_score_increase(score_value)
	
# Pausing game, not fully working yet
#func _input(event):
	#if event is InputEventKey and event.pressed:
		#if event.keycode == KEY_ESCAPE:
			#get_tree().paused = true
	#
