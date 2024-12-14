class_name Menu
extends Control


func _ready():
	var window_size = DisplayServer.window_get_size()
	audioPlayer.play_main_menu()
	

func _on_play_pressed() -> void:
	signals.button_click.emit()
	#get_tree().change_scene_to_file("res://scenes/stage1.tscn")
	scene_switcher.switch_scene("res://scenes/stage1.tscn")
	
	

func _on_credits_pressed() -> void:
	signals.button_click.emit()
	scene_switcher.switch_scene("res://scenes/credits.tscn")
	

func _on_exit_pressed() -> void:
	signals.button_click.emit()
	get_tree().quit()
