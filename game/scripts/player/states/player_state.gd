class_name PlayerState extends Node

var player: PlayerCharacter
var enter_timestamp: float

func transition(input: InputPackage) -> String:
	return name

func on_enter(previous_state: String):
	mark_enter_timestamp()

func on_exit():
	pass

func update(input: InputPackage, delta: float):
	pass


func mark_enter_timestamp():
	enter_timestamp = Time.get_unix_time_from_system()

func time_in_state() -> float:
	return Time.get_unix_time_from_system() - enter_timestamp

func has_passed(time: float):
	return time < time_in_state()
