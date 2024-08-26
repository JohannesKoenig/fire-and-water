class_name MainMenu extends Node2D


@onready var level_transitions = $LevelTransitions
@onready var scene_fader = $CanvasLayer/SceneFader

func _ready():
	scene_fader.fade_in()

func transition_to_level():
	scene_fader.fade_out()
	await scene_fader.fading_out_finished
	get_tree().change_scene_to_file("res://scenes/meta_progression.tscn")

func close_application():
	get_tree().quit()
