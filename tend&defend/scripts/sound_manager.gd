class_name SoundManager
extends Node

@onready var shoot_sfx = preload("res://assets/sfx/shoot.mp3")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	signals.turret_shot.connect(_on_turret_shoot)
	signals.button_click.connect(_on_button_click)
	signals.turret_damaged.connect(_on_turret_damaged)
	signals.turret_damaged.connect(_on_turret_death)

# Two ways of doing it
func _on_turret_shoot() -> void:
	$shoot.play()
	#audioPlayer.play_SFX(shoot_sfx, 0.0)

func _on_button_click() -> void:
	$buttonClick.play()

func _on_turret_damaged() -> void:
	$turret_damaged.play()

func _on_turret_death() -> void:
	$turret_death.play()
