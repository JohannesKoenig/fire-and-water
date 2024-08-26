class_name SceneFader extends Panel

signal fading_in_finished
signal fading_out_finished

@onready var animation_player = $AnimationPlayer


func fade_out():
	animation_player.play("fade_out")

func fade_in():
	animation_player.play("fade_in")

func finished_fade_out():
	fading_out_finished.emit()

func finished_fade_in():
	fading_in_finished.emit()
