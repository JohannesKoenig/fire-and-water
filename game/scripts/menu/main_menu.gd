class_name MainMenu extends Node2D


@onready var level_transitions = $LevelTransitions


func transition_to_level():
	get_tree().change_scene_to_file("res://scenes/meta_progression.tscn")

func close_application():
	get_tree().quit()
