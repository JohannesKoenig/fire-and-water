extends ExitState

@export var transition_time: float = 2

func transition(input_package: ExitInputPackage) -> String:
	if len(input_package.actions) == 1:
		return "Idle"
	if has_passed(transition_time):
		return "Exit"
	return name
