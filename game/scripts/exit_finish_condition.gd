class_name ExitFinishCondition extends FinishCondition

@export var exit: Exit

func is_satisfied() -> bool:
	if exit.model.exit_state_machine.current_state == "Exit":
		return true
	return false

