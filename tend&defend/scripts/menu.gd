class_name Menu
extends Control


func _ready():
	var window_size = DisplayServer.window_get_size()
	print("Window dimensions: ", window_size.x, "x", window_size.y)



func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/stage1.tscn")
	
	

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
	

func _on_exit_pressed() -> void:
	get_tree().quit()
