class_name PlayerInput extends Node

@export var player_id: int = 0


func get_input() -> InputPackage:
	var input_package = InputPackage.new()
	input_package.direction = Input.get_axis(
		_contextualize_input_name("left"),
		_contextualize_input_name("right"),
	)
	
	if Input.is_action_just_pressed(_contextualize_input_name("jump")):
		input_package.actions.append("jump")
	return input_package
	

func _contextualize_input_name(input_name: String) -> String:
	return input_name + "_" + str(player_id)
