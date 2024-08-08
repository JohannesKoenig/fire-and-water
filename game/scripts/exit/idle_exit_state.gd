extends ExitState


func transition(input_package: ExitInputPackage) -> String:
	if len(input_package.actions) > 1:
		return "TransitionToExit"
	return name

