class_name ExitInputs extends Node2D

@onready var area_2d = $Area2D

func get_input() -> ExitInputPackage:
	var input_package = ExitInputPackage.new()
	
	input_package.actions.append("Idle")
	
	if len(area_2d.get_overlapping_areas()) >= 2:
		input_package.actions.append("TransitionToExit")

	return input_package
