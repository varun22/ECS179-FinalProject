class_name Credits
extends Control

func _ready() -> void:
	var window_size = DisplayServer.window_get_size()
	audioPlayer.play_main_menu()

func _on_main_menu_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/menu.tscn")
