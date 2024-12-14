class_name GameOver
extends Control

func _ready() -> void:
	var window_size = DisplayServer.window_get_size()
	audioPlayer.play_game_over()

func _on_main_menu_pressed() -> void:
	signals.button_click.emit()
	scene_switcher.switch_scene("res://scenes/menu.tscn")
