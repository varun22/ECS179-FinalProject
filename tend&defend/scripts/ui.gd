extends CanvasLayer
class_name UI

@onready var score_label: Label = %Score

#TODO: Add signals into our main game script and our enemy scripts so that
# 	   they can call _on_score_increase()

var score = 0:
	set(new_score):
		score = new_score
		_update_score_label()

func _ready():
	_update_score_label()

func _update_score_label():
	score_label.text = str(score)

# This will be called by an enemy upon death & by each wave to increase score
# Any other ideas for updating score?
func _on_score_increase(increase) -> void:
		if increase:
			score += increase
