class_name AttackCommand
extends Command 


func execute(character: Player) -> Status:
	character.attacking = true
	return Status.DONE
