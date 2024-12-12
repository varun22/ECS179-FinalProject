class_name EnemyFactory
extends Node

# Export enemy in as packed scene
@export var enemy:PackedScene

# Builds and returns an enemy to be used in waves_manager
func build(enemy_spec:EnemySpec) -> Enemy:
	var new_enemy = enemy.instantiate() as Enemy
	new_enemy.damage = enemy_spec.damage
	new_enemy.speed = enemy_spec.speed
	new_enemy.health = enemy_spec.health
	new_enemy.type = enemy_spec.type
	
	return new_enemy
