class_name MoveRightCommand
extends Command


func execute(character: Player) -> Status:
	var input = character.SPEED
	character.velocity.x = input
	#character.sprite.flip_h = false
	character.change_facing(Player.Facing.RIGHT)
	return Status.DONE
