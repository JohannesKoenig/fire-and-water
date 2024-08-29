class_name CurrentLevelResource extends Resource

var current_level: String
var can_shoot_ball: bool:
	set(value):
		can_shoot_ball = value
		can_shoot_ball_changed.emit(value)
		SaveGameManager.write_savegame()

signal can_shoot_ball_changed(value: bool)
var collected_fire_gem: bool = false
var collected_water_gem: bool = false
