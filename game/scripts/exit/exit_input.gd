class_name ExitInputs extends Node2D

@onready var area_2d = $Area2D

func get_input() -> ExitInputPackage:
	var input_package = ExitInputPackage.new()
	
	input_package.actions.append("Idle")
	
	if area_2d.has_overlapping_areas():
		input_package.actions.append("TransitionToExit")

	return input_package
