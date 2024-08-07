extends Node

var LEVEL_LAYOUT = "res://resources/level_layout.json"
var data

func load_from_file():
	if data == null:
		return
	
	var json = JSON.new()
	var error = json.parse(LEVEL_LAYOUT)
	if error == OK:
		data = json.data

func get_next_level(current_level: String) -> Array[String]:
	load_from_file()
	var transitions: Array = data["transitions"]
	var transitions_from_current_level = transitions.filter(
		func(transition): return transition["from"] == current_level
	)
	return transitions_from_current_level.map(
		func(transition): return transition["to"]
	)
	
func get_first_level() -> String:
	load_from_file()
	return data["first_level"]
