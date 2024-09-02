class_name MainMenu extends Node2D


@onready var level_transitions = $LevelTransitions
@onready var scene_fader = $CanvasLayer/SceneFader
@onready var animation_player = $AnimationPlayer
@onready var start_button = $CanvasLayer/CenterContainer/VBoxContainer/VBoxContainer/StartButton
@onready var exit_button = $CanvasLayer/CenterContainer/VBoxContainer/VBoxContainer/ExitButton
@onready var settings_menu = $CanvasLayer/SettingsMenu


var transitioning: bool = false

func on_animation_finished(animation_name: String):
	if animation_name == "intro":
		start_button.disabled = false
		exit_button.disabled = false

func _ready():
	if SettingsManager.has_savegame():
		SettingsManager.load_savegame()
	settings_menu.visible = false
	if SaveGameManager.has_savegame():
		start_button.text = "Continue"
	scene_fader.modulate = Color(0,0,0,0)
	animation_player.animation_finished.connect(on_animation_finished)
	start_button.disabled = true
	exit_button.disabled = true
	start_button.grab_focus()

func _process(_delta):
	if Input.is_action_just_pressed("Skip"):
		animation_player.play("intro")
		animation_player.advance(8.0)

func transition_to_level():
	if transitioning:
		return
	transitioning = true
	scene_fader.fade_out()
	await scene_fader.fading_out_finished
	if SaveGameManager.has_savegame():
		get_tree().change_scene_to_file("res://scenes/meta_progression.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/intro_cutscene.tscn")

func close_application():
	get_tree().quit()


func _on_settings_button_pressed():
	settings_menu.visible = true
