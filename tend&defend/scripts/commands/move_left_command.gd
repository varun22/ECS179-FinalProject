class_name MoveLeftCommand
extends Command


func execute(character: Player) -> Status:
	var input = -1 * character.SPEED
	character.velocity.x = input
	#character.sprite.flip_h = true
	character.change_facing(Player.Facing.LEFT)
	return Status.DONE
