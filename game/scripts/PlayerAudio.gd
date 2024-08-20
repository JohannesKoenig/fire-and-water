class_name PlayerAudio extends AudioStreamPlayer2D

var jump_sound: AudioStream = preload("res://assets/sounds/Jump.mp3")
var fire_ball_sound: AudioStream = preload("res://assets/sounds/Attack.mp3")

var _player_state_machine: PlayerStateMachine

var stream_playback: AudioStreamPlaybackPolyphonic

func _ready():
	play()
	stream_playback = get_stream_playback()

func accept_model(player_state_machine: PlayerStateMachine):
	_player_state_machine = player_state_machine
	var shoot_state = _player_state_machine.states["Shoot"]
	shoot_state.shoot.connect(_play_fire_ball)
	var jump_state = _player_state_machine.states["Jump"]
	jump_state.jump.connect(_play_jump_sound)

func _play_jump_sound():
	stream_playback.play_stream(jump_sound)

func _play_fire_ball():
	stream_playback.play_stream(fire_ball_sound)
