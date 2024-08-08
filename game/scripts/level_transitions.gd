class_name LevelTransitions extends Node

var LEVEL_LAYOUT = "res://resources/level_layout.json"
var data


func _ready():
	load_from_file()


func load_from_file():
	if data != null:
		return
	
	var file_content = FileAccess.get_file_as_string(LEVEL_LAYOUT)
	var json = JSON.new()
	var error = json.parse(file_content)
	if error == OK:
		data = json.data
	else:
		print(json.get_error_message())

func get_next_level(current_level: String) -> Array[String]:
	var transitions: Array = data["transitions"]
	var transitions_from_current_level = transitions.filter(
		func(transition): return transition["from"] == current_level
	)
	return transitions_from_current_level.map(
		func(transition): return transition["to"]
	)
	
func get_first_level() -> String:
	return data["first_level"]

func get_level_path(level_name: String) -> String:
	return data["levels"][level_name]["file"]
