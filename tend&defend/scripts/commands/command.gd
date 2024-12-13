class_name Command

enum Status {
	ACTIVE,
	DONE,
	ERROR,
}

func execute(_character: Player) -> Status:
	return Status.DONE
