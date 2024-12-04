class_name WavesManager
extends Node

@export var enemy:PackedScene

@onready var enemy_fact:EnemyFactory

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
	wave = 1
	calc_num_to_spawn()
	create_enemy_schedule()
	spawn_enemies()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if check_end():
		wave += 1
		calc_num_to_spawn()
		create_enemy_schedule()
		spawn_enemies()

# Fills placement_array with random placement and 
func create_enemy_schedule() -> void:
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
		enemy_spec.damage = 10
		enemy_spec.speed = 5
		enemy_spec.health = 100
		
		var new_enemy = enemy_fact.build(enemy_spec)
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
	var check_for_enemies:Array[Node] = $"../EnemySpawns".get_children()
	# cycle through each one and check if it is a enemy, if yes,return true
	for i in check_for_enemies:
		if i is Enemy:
			return true
	return false
	
