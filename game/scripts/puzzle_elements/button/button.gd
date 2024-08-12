class_name ButtonPuzzleElement extends Node2D

@onready var area_2d = $Area2D
@onready var animation_player = $AnimationPlayer


signal button_active
signal button_inactive

func _ready():
	animation_player.play("button")

func _process(delta):
	if area_2d.has_overlapping_areas():
		if animation_player.current_animation != "button_down":
			animation_player.play("button_down")
			button_active.emit()
	else:
		if animation_player.current_animation != "button":
			animation_player.play("button")
			button_inactive.emit()
