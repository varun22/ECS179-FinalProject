class_name SoundManager
extends Node

#@onready var shoot_sfx = preload("res://assets/sfx/shoot.mp3")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	signals.turret_shot.connect(_on_turret_shoot)
	signals.button_click.connect(_on_button_click)
	signals.turret_damaged.connect(_on_turret_damaged)
	signals.turret_death.connect(_on_turret_death)
	signals.player_death.connect(_on_player_death)
	signals.player_hurt.connect(_on_player_hurt)
	signals.swing_weapon.connect(_on_weapon_swing)
	signals.projectile_hit.connect(_on_projectile_hit)
	signals.enemy_death_1.connect(_on_enemy_death_1)
	signals.enemy_death_2.connect(_on_enemy_death_2)

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
	
func _on_player_death() -> void:
	$player_death.play()
	
func _on_weapon_swing() -> void:
	$swing_weapon.play()
	
func _on_projectile_hit() -> void:
	$projectile_hit.play()
	
func _on_enemy_death_1() -> void:
	$enemy_dead_1.play()

func _on_enemy_death_2() -> void:
	$enemy_dead_2.play()

func _on_player_hurt() -> void:
	$player_hurt.play()
