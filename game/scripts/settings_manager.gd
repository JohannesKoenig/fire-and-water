extends Node

@onready var settings_resource: SettingsResource = preload("res://resources/settings_resource.tres")


var MENU_SAVE_PATH = "user://settings.json"

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

func delete_savegame():
	var file := FileAccess.open(MENU_SAVE_PATH, FileAccess.READ)
	if !file:
		return
	DirAccess.remove_absolute(MENU_SAVE_PATH)

func game_data_as_dictionary() -> Dictionary:
	return {
		"volume_percentage": settings_resource.volume_percentage,
		"brightness_percentage": settings_resource.brightness_percentage
	}

func game_data_from_dictionary(data: Dictionary):
	settings_resource.volume_percentage = data["volume_percentage"]
	settings_resource.brightness_percentage = data["brightness_percentage"]
