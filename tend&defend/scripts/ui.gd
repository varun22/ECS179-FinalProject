extends CanvasLayer
class_name UI

@onready var score_label: Label = %Score
@onready var wave_label: Label = %Wave
@onready var round: Control = $HUD/Round
@onready var currency_label: Label = $HUD/Top2/VBoxContainer/HBoxContainer/Currency


var current_wave: int = 1 
var score = globalVars.score:
	set(new_score):
		score = new_score
		_update_score_label()

func _ready():
	_update_score_label()
	round.visible = false

func _process(_delta: float) -> void:
	currency_label.text = str(globalVars.currency)

func _update_score_label():
	score_label.text = str(score)

# This will be called by an enemy upon death & by each wave to increase score
# Any other ideas for when we need to update score
func _on_score_increase(increase) -> void:
		if increase:
			score += increase
			globalVars.score += increase
			
func _ui_on_wave_update(wave: int) -> void:
	current_wave = wave
	round.visible = true
	wave_label.text = str(current_wave)
	await get_tree().create_timer(3.0).timeout #show round for 3 seconds
	round.visible = false
