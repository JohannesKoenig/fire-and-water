class_name PullUpDoor extends Node2D

@onready var animation_player = $AnimationPlayer
@export var current_animation = "closed"
var start_next = true
# Called when the node enters the scene tree for the first time.
func _process(delta):
	if start_next:
		animation_player.play(current_animation)
		start_next = false
	if not animation_player.is_playing():
		match current_animation:
			"closing":
				current_animation = "closed"
				start_next = true
			"opening":
				current_animation = "open"
				start_next = true

	

func close():
	current_animation = "closing"
	start_next = true

func open():
	current_animation = "opening"
	start_next = true

