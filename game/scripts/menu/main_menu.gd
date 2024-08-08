class_name MainMenu extends Node2D


@onready var level_transitions = $LevelTransitions


func transition_to_level():
	var current_level = level_transitions.get_first_level()
	var level_path = level_transitions.get_level_path(current_level)
	get_tree().change_scene_to_file(level_path)

func close_application():
	get_tree().quit()
