class_name Player
extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_X: float = 1880.0
const HEALTH: float = 100.0

var y_positions: Array = [540, 650, 755, 870, 980]
var current_y_index: int = 2
var current_health: float = 100.0
var _dead: bool = false
var type:int = 3

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
	current_health = HEALTH
	bind_player_input_commands()
	

func bind_player_input_commands():
	right_cmd = MoveRightCommand.new()
	left_cmd = MoveLeftCommand.new()
	attack = AttackCommand.new()
	idle = IdleCommand.new()

func change_facing(new_facing:Facing) -> void:
	facing = new_facing

func move_up():
	if current_y_index > 0:
		current_y_index -= 1
		global_position.y = y_positions[current_y_index]
		global_position.x += 77

func move_down():
	if current_y_index < y_positions.size() - 1:
		current_y_index += 1
		global_position.y = y_positions[current_y_index]
		global_position.x -= 77


func _physics_process(delta: float) -> void:
	move_and_slide()

	var move_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	var min_x = 340 - (current_y_index - 2) * 77
	
	if move_input > 0.1:
		print("moving")
		if type == 1:
			$Sprite2d/AnimationPlayer.play("stick_walk_right")
		elif type == 2:
			$Sprite2d/AnimationPlayer.play("sword_walk_right")
		elif type == 3:
			$Sprite2d/AnimationPlayer.play("hammer_move_right")
		else: 
			$Sprite2d/AnimationPlayer.play("racket_move_right")
		right_cmd.execute(self)
	elif Input.is_action_just_pressed("attack"):
		print("attacked")
		if type == 1:
			$Sprite2d/AnimationPlayer.play("stick_attack")
		elif type == 2:
			$Sprite2d/AnimationPlayer.play("sword_attack")
		elif type == 3:
			$Sprite2d/AnimationPlayer.play("hammer_attack")
		else: 
			$Sprite2d/AnimationPlayer.play("racket_attack")
		attack.execute(self)
		
	elif move_input < -0.1:
		if type == 1:
			$Sprite2d/AnimationPlayer.play("stick_walk_right")
		elif type == 2:
			$Sprite2d/AnimationPlayer.play("sword_walk_right")
		elif type == 3:
			$Sprite2d/AnimationPlayer.play("hammer_move_right")
		else: 
			$Sprite2d/AnimationPlayer.play("racket_move_right")
		left_cmd.execute(self)
	else:
		if(!$Sprite2d/AnimationPlayer.is_playing()):
			if type == 1:
				$Sprite2d/AnimationPlayer.play("stick_idle")
			elif type == 2:
				$Sprite2d/AnimationPlayer.play("sword_idle")
			elif type == 3:
				$Sprite2d/AnimationPlayer.play("hammer_idle")
			else: 
				$Sprite2d/AnimationPlayer.play("racket_idle")
		idle.execute(self)
		
	
	self.global_position.x = clamp(self.global_position.x, min_x, MAX_X)
		
	if Input.is_action_just_pressed("move_up"):
		move_up()
	elif Input.is_action_just_pressed("move_down"):
		move_down()

func take_damage(damage:int) -> void:
	current_health -= damage
	if 0 >= current_health:
		_dead = true
	


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
