extends CanvasLayer
class_name UI

@onready var score_label: Label = %Score
@onready var wave_label: Label = %Wave
@onready var round: Control = $HUD/Round
@onready var currency_label: Label = $HUD/Top2/VBoxContainer/HBoxContainer/Currency
@onready var health_container: HBoxContainer = $HUD/Top3/VBoxContainer/HBoxContainer

var current_wave: int = 1
var score = globalVars.score:
	set(new_score):
		score = new_score
		_update_score_label()
		
var game_health: int = globalVars.game_health:
	set(value):
		game_health = value
		_update_health_display()

var heart_texture: Texture = preload("res://assets/heart.png")

func _ready():
	_update_score_label()
	_update_health_display()
	round.visible = false

func _process(_delta: float) -> void:
	currency_label.text = str(globalVars.currency)

func _update_score_label():
	score_label.text = str(score)

func _on_score_increase(increase) -> void:
	if increase:
		score += increase
		globalVars.score += increase

func _ui_on_wave_update(wave: int) -> void:
	current_wave = wave
	round.visible = true
	wave_label.text = str(current_wave)
	await get_tree().create_timer(3.0).timeout
	round.visible = false

func _update_health_display():
	#health_container.clear_children()

	for i in range(globalVars.game_health - 1):
		var heart = TextureRect.new()
		heart.texture = heart_texture
		heart.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		health_container.add_child(heart)
