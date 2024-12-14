class_name Menu
extends Control


func _ready():
	var window_size = DisplayServer.window_get_size()
	audioPlayer.play_main_menu()
	

func _on_play_pressed() -> void:
	# Make sure all global variables are reset on play
	globalVars.currency = 0
	globalVars.game_health = 3
	globalVars.score = 0
	globalVars.wave_num = 1
	globalVars.player_type = 1
	globalVars.num_to_spawn_one = 5
	globalVars.num_to_spawn_total = 5
	
	for n in 5:
		turretType.turret_health[n] = 100.0
		turretType.type_array[n] = turretType.Type.BASIC
		turretType.frequency_level[n] = 1
		turretType.power_level[n] = 1
		turretType.reach_level[n] = 1
	
	signals.button_click.emit()
	#get_tree().change_scene_to_file("res://scenes/stage1.tscn")
	scene_switcher.switch_scene("res://scenes/stage1.tscn")
	
	

func _on_credits_pressed() -> void:
	signals.button_click.emit()
	scene_switcher.switch_scene("res://scenes/credits.tscn")
	

func _on_exit_pressed() -> void:
	signals.button_click.emit()
	get_tree().quit()
