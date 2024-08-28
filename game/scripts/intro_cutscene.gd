class_name IntroCutscene extends Node2D

@onready var scene_fader = $CanvasLayer/SceneFader
@onready var animation_player = $AnimationPlayer

static var ANIMATION_LENGTH: float = 30

var skipping: bool = false

func _ready():
	scene_fader.fade_in()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Skip"):
		skip_to_next_scene()
		
func skip_to_next_scene():
	if skipping:
		return
	skipping = true
	scene_fader.fade_out()
	await scene_fader.fading_out_finished
	get_tree().change_scene_to_file("res://scenes/meta_progression.tscn")
