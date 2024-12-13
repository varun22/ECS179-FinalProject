extends Area2D
#remove Mask 3 since just used for testing
func _ready() -> void:
	signals.turret_shot.connect(_free_bananas)

func _on_body_entered(body):
	#Update score
	queue_free()
	
func _free_bananas() -> void:
	print("Free all banans")
	queue_free()
