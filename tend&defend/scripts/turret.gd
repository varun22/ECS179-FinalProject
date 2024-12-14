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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if shoot_timer.is_stopped():
		shoot()
	
func shoot() -> void:
	match turretType.type_array[lane - 1]:
		turretType.Type.BASIC:
			proj_spec.type = 1
			$Turret/AnimationPlayer.play("base_tower_attack")
		turretType.Type.POWER:
			proj_spec.type = 2
			$Turret/AnimationPlayer.play("power_turret_attack")
		turretType.Type.REACH:
			proj_spec.type = 3
			$Turret/AnimationPlayer.play("range_turret_attack")
		turretType.Type.FREQUENCY:
			proj_spec.type = 4
			$Turret/AnimationPlayer.play("freq_tower_attack")
	
	proj_spec.reach = reach
	proj_spec.damage = damage
	
	
	var new_proj = proj_fact.build(proj_spec)
	add_child(new_proj)
	
	signals.turret_shot.emit()
	shoot_timer.start(frequency)
	
	
func take_damage(damage_amt: float) -> void:
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
	
	
	
