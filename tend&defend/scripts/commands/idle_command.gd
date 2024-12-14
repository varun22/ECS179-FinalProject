class_name IdleCommand
extends Command

func execute(character: Player) -> Status:
	character.velocity.x = 0
	return Status.DONE
