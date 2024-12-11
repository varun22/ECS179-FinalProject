class_name SceneSwitch
extends Node

var current_scene = null

func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(-1)
	#print(current_scene)
	
func switch_scene(res_path):
	_deffered_switch_scene.call_deferred(res_path)
	
func _deffered_switch_scene(res_path):
	current_scene.free()
	var r = load(res_path)
	current_scene = r.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
