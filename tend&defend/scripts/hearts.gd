class_name Hearts
extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if globalVars.game_health == 2:
		$heart3.visible = false
	elif globalVars.game_health == 1:
		$heart3.visible = false
		$heart2.visible = false
	elif globalVars.game_health == 0:
		$heart3.visible = false
		$heart2.visible = false
		$heart1.visible = false
