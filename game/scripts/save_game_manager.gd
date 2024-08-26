extends Node

@onready var current_level_resource: CurrentLevelResource = preload("res://resources/game_state/current_level_resource.tres")


var MENU_SAVE_PATH = "user://save.json"

func has_savegame() -> bool:
	var file := FileAccess.open(MENU_SAVE_PATH, FileAccess.READ)
	if !file:
		return false
	else:
		return true

func write_savegame():
	var file := FileAccess.open(MENU_SAVE_PATH, FileAccess.WRITE)
	var data := game_data_as_dictionary()
	var json_string := JSON.new().stringify(data)
	file.store_string(json_string)
	file.close()

func load_savegame():
	var file := FileAccess.open(MENU_SAVE_PATH, FileAccess.READ)
	if !file:
		return
	var content = file.get_as_text()
	file.close()
	var data = JSON.parse_string(content)
	if data:
		game_data_from_dictionary(data)

func game_data_as_dictionary() -> Dictionary:
	return {
		"current_level": current_level_resource.current_level,
		"can_shoot_ball": current_level_resource.can_shoot_ball
	}

func game_data_from_dictionary(data: Dictionary):
	current_level_resource.current_level = data["current_level"]
	current_level_resource.can_shoot_ball = data["can_shoot_ball"]
