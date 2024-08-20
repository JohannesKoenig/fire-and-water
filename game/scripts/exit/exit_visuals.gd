class_name ExitVisuals extends Node2D

var model: ExitModel
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var audio_stream_player_2d = $AudioStreamPlayer2D


func accept_model(model: ExitModel):
	self.model = model
	var state_machine = model.exit_state_machine
	var transition_state = state_machine.states["TransitionToExit"]
	transition_state.transitioning.connect(audio_stream_player_2d.play)

func _process(delta):
	match model.exit_state_machine.current_state:
		"Idle":
			audio_stream_player_2d.stop()
			animation_player.play("Idle")
		"TransitionToExit":
			animation_player.play("Transporting")
		"Exit":
			animation_player.play("Exit")
