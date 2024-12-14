class_name ProjectileFactory
extends Node

#Exports projectile scene
@export var projectile:PackedScene

# Builds and returns an projectile
func build(proj_spec:ProjectileSpec) -> Projectile:
	var new_projectile = projectile.instantiate() as Projectile
	new_projectile.reach = proj_spec.reach
	new_projectile.damage = proj_spec.damage
	new_projectile.type = proj_spec.type
	return new_projectile
