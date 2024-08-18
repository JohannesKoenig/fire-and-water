extends Node2D


@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var player_audio = $PlayerAudio

@export var rig: Rig
@export var player_input : PlayerInput

var _player_state_machine: PlayerStateMachine

func accept_model(player_state_machine: PlayerStateMachine):
	_player_state_machine = player_state_machine
	player_audio.accept_model(player_state_machine)

func _process(delta):
	var input_package = player_input.get_input()
	var direction = input_package.direction
	
	if rig.facing_right: 
		scale.x = 1
	else: 
		scale.x = -1
		
	animated_sprite_2d.play(_player_state_machine.current_state)
	
	input_package.queue_free()
