class_name MainMenu extends Node2D


@onready var level_transitions = $LevelTransitions
@onready var scene_fader = $CanvasLayer/SceneFader

func _ready():
	scene_fader.modulate = Color(0,0,0,0)

func transition_to_level():
	scene_fader.fade_out()
	await scene_fader.fading_out_finished
	if SaveGameManager.has_savegame():
		get_tree().change_scene_to_file("res://scenes/meta_progression.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/intro_cutscene.tscn")

func close_application():
	get_tree().quit()
