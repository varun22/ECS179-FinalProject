class_name Turret
extends StaticBody2D

#Put in logic to create and shoot projectiles based on the given spec
@export var projectile: PackedScene
@onready var proj_fact:ProjectileFactory = $"../ProjectileFactory"

var reach:float = 50.0
var damage:float = 10.0
var frequency:float = 4.0
var type:turretType.Type = turretType.Type.BASIC

var shoot_timer:Timer
var proj_spec = ProjectileSpec.new()

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
	# Make proj spec based off turret spec
	$BaseTurret/AnimationPlayer.play("base_tower_attack")
	proj_spec.reach = reach
	proj_spec.damage = damage
	
	# Build proj based off spec and add it as child of turret
	var new_proj = proj_fact.build(proj_spec)
	add_child(new_proj)
	
	# Start timer for next shoot
	shoot_timer.start(frequency)
	
	
	
