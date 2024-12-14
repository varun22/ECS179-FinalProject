class_name Turret
extends StaticBody2D

#Put in logic to create and shoot projectiles based on the given spec
@export var projectile: PackedScene
@onready var proj_fact:ProjectileFactory = $"../ProjectileFactory"

var reach:float = 5.0
var damage:float = 10.0
var frequency:float = 5.0
var health:float = 100.0
var type:turretType.Type = turretType.Type.BASIC
var lane:int

var shoot_timer:Timer
var proj_spec = ProjectileSpec.new()
var payback_rate:float = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Timer for shoot time
	shoot_timer = Timer.new()
	shoot_timer.one_shot = true
	add_child(shoot_timer)
	
	$HealthBar.max_value = 100.0
	$HealthBar.value = turretType.turret_health[lane]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$HealthBar.value = turretType.turret_health[lane]
	if shoot_timer.is_stopped():
		shoot()
	
func shoot() -> void:
	# Make proj spec based off turret spec
	if turretType.type_array[lane] == turretType.Type.BASIC:
		$Turret/AnimationPlayer.play("base_tower_attack")
	elif turretType.type_array[lane] == turretType.Type.POWER:
		$Turret/AnimationPlayer.play("power_turret_attack")
	elif turretType.type_array[lane] == turretType.Type.REACH:
		$Turret/AnimationPlayer.play("range_turret_attack")
	elif turretType.type_array[lane] == turretType.Type.FREQUENCY:
		$Turret/AnimationPlayer.play("freq_tower_attack")
		
	proj_spec.reach = reach
	proj_spec.damage = damage
	
	# Build proj based off spec and add it as child of turret
	var new_proj = proj_fact.build(proj_spec)
	add_child(new_proj)
	
	signals.turret_shot.emit()
	
	# Start timer for next shoot
	shoot_timer.start(frequency)
	
	
func take_damage(damage_amt: float) -> void:
	signals.turret_damaged.emit()
	print("took damage ", damage_amt)
	health -= damage_amt
	turretType.turret_health[lane] -= damage_amt
	if health <= 0:
		turretType.turret_health[lane] = 0.0
		die()
	
func die() -> void:
	globalVars.currency += calculate_payback(lane)
	if(globalVars.game_health > 0):
		--globalVars.game_health
		if(globalVars.game_health == 0):
			#switch to game over screen
			pass
	turretType.type_array[lane] = turretType.Type.BASIC
	$Turret/AnimationPlayer.play("base_tower_death")
	await get_tree().create_timer(0.8).timeout
	queue_free()
	
# Calculate how much currency player gets back for a destroyed turret (50% of what it costs is given back)
func calculate_payback(lane_num: int) -> int:
	var payback:int = 0
	if turretType.type_array[lane_num] == turretType.Type.BASIC:
		return 0
	elif turretType.type_array[lane_num] == turretType.Type.POWER:
		payback += 25
		payback += (turretType.power_level[lane_num] - 1) * globalVars.currency_to_upgrade
		payback * payback_rate
	elif turretType.type_array[lane_num] == turretType.Type.REACH:
		payback += 25
		payback += (turretType.reach_level[lane_num] - 1) * globalVars.currency_to_upgrade
		payback * payback_rate
	elif turretType.type_array[lane_num] == turretType.Type.FREQUENCY:
		payback += 25
		payback += (turretType.frequency_level[lane_num] - 1) * globalVars.currency_to_upgrade
		payback * payback_rate
	return payback
	
	
	
