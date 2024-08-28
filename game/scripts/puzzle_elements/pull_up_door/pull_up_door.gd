class_name PullUpDoor extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var sprite_animation_player = $SpriteAnimationPlayer
@export var current_animation = "closed"
@onready var audio_stream_player_2d = $AudioStreamPlayer2D


var start_next = true
# Called when the node enters the scene tree for the first time.
func _process(delta):
	if start_next:
		start_next = false
		animation_player.play(current_animation)
	if not animation_player.is_playing():
		match current_animation:
			"closing":
				current_animation = "closed"
				start_next = true
				audio_stream_player_2d.stop()
			"opening":
				current_animation = "open"
				start_next = true
				audio_stream_player_2d.stop()

	

func close():
	var remaining = 0
	if current_animation == "closed":
		return
	if current_animation == "opening":
		remaining = current_animation_remaining_time()
	current_animation = "closing"
	animation_player.play(current_animation)
	animation_player.advance(remaining)
	sprite_animation_player.play("deactivate")
	audio_stream_player_2d.play()

func open():
	var remaining = 0
	if current_animation == "open":
		return
	if current_animation == "closing":
		remaining = current_animation_remaining_time()
	current_animation = "opening"
	animation_player.play(current_animation)
	animation_player.advance(remaining)
	sprite_animation_player.play("activate")
	audio_stream_player_2d.play()

func current_animation_remaining_time():
	var current_animation_progress = animation_player.current_animation_position
	var current_animation_time = animation_player.current_animation_length
	return current_animation_time - current_animation_progress


func _on_church_door_btn_button_inactive():
	pass # Replace with function body.
