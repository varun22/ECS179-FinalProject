class_name Banana
extends Area2D

func _ready() -> void:
	# Connect the new_wave signal to the _free_bananas function
	signals.new_wave.connect(_free_bananas)

func _on_body_entered(body):
	print("Banana gained")
	globalVars.currency += 20.0
	queue_free()

func _free_bananas() -> void:
	print("Free all bananas")
	# Find all nodes of the banana
	var parent_scene = get_tree().get_current_scene()
	for child in parent_scene.get_children():
		if child is Banana:  
			child.queue_free()
