class_name Player
extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_X: float = 1880.0
const HEALTH: float = 100.0

var y_positions: Array = [555, 670, 785, 900, 1015]
var current_y_index: int = 2
var current_health: float = 100.0
var _dead: bool = false
var type:int = 1
var damage:float = 20.0

enum Facing { 
	LEFT,
	RIGHT,
}
var right_cmd : Command
var left_cmd : Command
var up_cmd : Command
var down_cmd : Command
var idle: Command
var attack : Command

var facing:Facing = Facing.RIGHT
var attacking : bool: 
	set(value): 
		attacking = value
	get():
		return attacking
		
func _ready():
	type = globalVars.player_type
	
	current_health = HEALTH
	target_position = global_position
	bind_player_input_commands()
	
	$HealthBar.max_value = HEALTH
	$HealthBar.value = current_health
	
	if globalVars.player_type == 1:
		damage = 20.0
	elif globalVars.player_type == 2:
		damage = 25.0
	elif globalVars.player_type == 3:
		damage = 30.0
	elif globalVars.player_type == 4:
		damage = 50.0

func bind_player_input_commands():
	right_cmd = MoveRightCommand.new()
	left_cmd = MoveLeftCommand.new()
	attack = AttackCommand.new()
	idle = IdleCommand.new()

func change_facing(new_facing:Facing) -> void:
	facing = new_facing

var target_position: Vector2
var lerp_speed: float = 10.0

func move_up():
	if current_y_index > 0:
		current_y_index -= 1
		target_position.y = y_positions[current_y_index]
		target_position.x = global_position.x + 77

func move_down():
	if current_y_index < y_positions.size() - 1:
		current_y_index += 1
		target_position.y = y_positions[current_y_index]
		target_position.x = global_position.x - 77

func _physics_process(delta: float) -> void:
	$HealthBar.value = current_health
	move_and_slide()

	var move_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if move_input > 0.1:
		if type == 1:
			$Sprite2d/AnimationPlayer.play("sword_walk_right")
		elif type == 2:
			$Sprite2d/AnimationPlayer.play("stick_walk_right")
		elif type == 3:
			$Sprite2d/AnimationPlayer.play("hammer_move_right")
		else: 
			$Sprite2d/AnimationPlayer.play("racket_move_right")
		right_cmd.execute(self)
		target_position.x += SPEED * delta 
	elif move_input < -0.1:
		if type == 1:
			$Sprite2d/AnimationPlayer.play("sword_walk_right")
		elif type == 2:
			$Sprite2d/AnimationPlayer.play("stick_walk_right")
		elif type == 3:
			$Sprite2d/AnimationPlayer.play("hammer_move_right")
		else: 
			$Sprite2d/AnimationPlayer.play("racket_move_right")
		left_cmd.execute(self)
		target_position.x -= SPEED * delta 
	elif Input.is_action_just_pressed("attack"):
		if type == 1:
			$Sprite2d/AnimationPlayer.play("sword_attack")
		elif type == 2:
			$Sprite2d/AnimationPlayer.play("stick_attack")
		elif type == 3:
			$Sprite2d/AnimationPlayer.play("hammer_attack")
		else: 
			$Sprite2d/AnimationPlayer.play("racket_attack")
		attack.execute(self)
	elif Input.is_action_just_pressed("move_up"):
		$Sprite2d/AnimationPlayer.play("jump")
		move_up()
	elif Input.is_action_just_pressed("move_down"):
		$Sprite2d/AnimationPlayer.play("jump")
		move_down()
	else:
		if (!$Sprite2d/AnimationPlayer.is_playing()):
			#if type == 1:
				#$Sprite2d/AnimationPlayer.play("sword_idle")
			if type == 2:
				$Sprite2d/AnimationPlayer.play("stick_idle")
			elif type == 3:
				$Sprite2d/AnimationPlayer.play("hammer_idle")
			elif type == 4: 
				$Sprite2d/AnimationPlayer.play("racket_idle")
		idle.execute(self)
	
	target_position.x = clamp(target_position.x, 0, MAX_X)
	
	global_position = lerp(global_position, target_position, lerp_speed * delta)
		
func take_damage(damage:int) -> void:
	current_health -= damage
	if 0 >= current_health:
		#don't spawn player until next round
		_dead = true
		$Sprite2d/AnimationPlayer.play("death")
		await get_tree().create_timer(0.8).timeout
		queue_free()
		
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
