class_name ExitState extends Node

var enter_timestamp: float

func transition(input_package: ExitInputPackage) -> String:
	return name

func update(input_package: ExitInputPackage, delta: float):
	pass

func exit_state():
	pass

func enter_state():
	mark_enter_timestamp()

func mark_enter_timestamp():
	enter_timestamp = Time.get_unix_time_from_system()

func time_in_state() -> float:
	return Time.get_unix_time_from_system() - enter_timestamp

func has_passed(time: float):
	return time < time_in_state()
