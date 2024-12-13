extends Area2D
#remove Mask 3 since just used for testing
func _on_body_entered(body):
	#Update score
	print("+1")
	queue_free()
	
func _free_bananas() -> void:
	print("Free all banans")
	queue_free()
