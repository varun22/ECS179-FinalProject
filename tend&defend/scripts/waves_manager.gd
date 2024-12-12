class_name WavesManager
extends Node

signal wave_update(value: int)

@export var enemy: PackedScene
@export var game: Game  # Reference to the Game script for connecting signals

@onready var enemy_fact:EnemyFactory = $"../EnemySpawns"
@onready var turret_fact:TurretFactory = $"../Turrets"

var wave:int
var num_to_spawn:int
# Array to store which lane to spawn each enemy in
var placement_array:Array[int]
# Array to store times between spawns
var timing_array:Array[float]
var enemy_spec:EnemySpec
var done_spawning:bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Builds turrets based on global types and stats in turret_type
	turret_fact.rebuild()
	wave = globalVars.wave_num
	await wait(3.0) #use for buy phase
	calc_num_to_spawn()
	create_enemy_schedule()
	spawn_enemies()
	
	#connect background music
	#var background_music = $"../BackgroundMusic"
	wave_update.connect(audioPlayer.on_wave_update)
	var ui = $"../UI"
	wave_update.connect(ui._ui_on_wave_update)
	wave_update.emit(wave)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if check_end():
		globalVars.wave_num += 1
		done_spawning = false
		#switch scene to buy menu, on player exit or timer end, switch back to stage1
		#consider currency, storing bought changes, etc.
		scene_switcher.switch_scene("res://scenes/buy_phase.tscn")
		
		# This never gets reached anymore due to scene switching
		# Update music playback speed, add title
		#wave_update.emit(wave)
		#calc_num_to_spawn()
		#create_enemy_schedule()
		#spawn_enemies()

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout


# Fills placement_array with random placement and 
func create_enemy_schedule() -> void:
	print("wave: ", wave)
	var rng = RandomNumberGenerator.new()
	for i in num_to_spawn:
		placement_array.push_back(rng.randi_range(1, 5))
		timing_array.push_back(rng.randf_range(1, 5))
	
# Checks if wave is over, if so start buy phase(not implemented yet)
func check_end() -> bool:
	if done_spawning == true and not check_enemy_exists():
		return true
	else:
		return false

# Can calculate some difficulty elements here (if wave is over 5, make _ out of _ enemies spawn with greater speed/damage/health)
func spawn_enemies() -> void:
	for i in num_to_spawn:
		enemy_spec = EnemySpec.new()
		enemy_spec.damage = 10
		enemy_spec.speed = 200
		enemy_spec.health = 100
		
		var new_enemy = enemy_fact.build(enemy_spec)
		#ADD All enemy signals here
		new_enemy.died.connect(game.on_enemy_died)  # Connect the `died` signal to Game

		if placement_array[i] == 1:
			$"../EnemySpawns/EnemySpawn1".add_child(new_enemy)
			await get_tree().create_timer(timing_array[i]).timeout
		elif placement_array[i] == 2:
			$"../EnemySpawns/EnemySpawn2".add_child(new_enemy)
			await get_tree().create_timer(timing_array[i]).timeout
		elif placement_array[i] == 3:
			$"../EnemySpawns/EnemySpawn3".add_child(new_enemy)
			await get_tree().create_timer(timing_array[i]).timeout
		elif placement_array[i] == 4:
			$"../EnemySpawns/EnemySpawn4".add_child(new_enemy)
			await get_tree().create_timer(timing_array[i]).timeout
		elif placement_array[i] == 5:
			$"../EnemySpawns/EnemySpawn5".add_child(new_enemy)
			await get_tree().create_timer(timing_array[i]).timeout
	
	done_spawning = true
			
# Very simple calculation right now, can tune later for better feel
func calc_num_to_spawn() -> void:
	num_to_spawn = wave + 4
	
# Checks if there are any instances of enemies left, if so, return true
func check_enemy_exists() -> bool:
	var check_parent_node:Array[Node] = $"../EnemySpawns".get_children()
	# cycle through each one and check if it is a enemy, if yes,return true
	for i in check_parent_node:
		var check_enemy_is:Array[Node] = i.get_children()
		for j in check_enemy_is:
			if j is Enemy:
				#print("enemy exists")
				return true
	return false
	
