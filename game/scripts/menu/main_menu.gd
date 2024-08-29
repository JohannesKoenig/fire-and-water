class_name MainMenu extends Node2D


@onready var level_transitions = $LevelTransitions
@onready var scene_fader = $CanvasLayer/SceneFader
@onready var animation_player = $AnimationPlayer
@onready var start_button = $CanvasLayer/CenterContainer/VBoxContainer/VBoxContainer/StartButton
@onready var exit_button = $CanvasLayer/CenterContainer/VBoxContainer/VBoxContainer/ExitButton

func on_animation_finished(animation_name: String):
	if animation_name == "intro":
		start_button.disabled = false
		exit_button.disabled = false

func _ready():
	scene_fader.modulate = Color(0,0,0,0)
	animation_player.animation_finished.connect(on_animation_finished)
	start_button.disabled = true
	exit_button.disabled = true

func _process(_delta):
	if Input.is_action_just_pressed("Skip"):
		animation_player.play("intro")
		animation_player.advance(8.0)

func transition_to_level():
	scene_fader.fade_out()
	await scene_fader.fading_out_finished
	if SaveGameManager.has_savegame():
		get_tree().change_scene_to_file("res://scenes/meta_progression.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/intro_cutscene.tscn")

func close_application():
	get_tree().quit()
