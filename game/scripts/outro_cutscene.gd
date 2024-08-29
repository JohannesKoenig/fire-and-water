extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var scene_fader = $CanvasLayer/SceneFader

# Called when the node enters the scene tree for the first time.
func _ready():
	scene_fader.fade_in()
	animation_player.play("outro")
	await animation_player.animation_finished
	scene_fader.fade_out()
	await scene_fader.fading_out_finished
	SaveGameManager.delete_savegame()
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
