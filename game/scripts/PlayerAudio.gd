class_name PlayerAudio extends AudioStreamPlayer2D

var jump_sound: AudioStream = preload("res://assets/sound_effects/player/Jump.mp3")
var fire_ball_sound: AudioStream = preload("res://assets/sound_effects/player/Attack.mp3")
var step_sound: AudioStream = preload("res://assets/sound_effects/player/step.mp3")

var _player_state_machine: PlayerStateMachine

var stream_playback: AudioStreamPlaybackPolyphonic

func _ready():
	play()
	stream_playback = get_stream_playback()

func accept_model(player_state_machine: PlayerStateMachine):
	_player_state_machine = player_state_machine
	var shoot_state = _player_state_machine.states["Shoot"]
	shoot_state.shoot.connect(_play_fire_ball)
	#var jump_state = _player_state_machine.states["Jump"]
	#jump_state.jump.connect(_play_jump_sound)

func _play_jump_sound():
	stream_playback.play_stream(jump_sound)

func _play_fire_ball():
	stream_playback.play_stream(fire_ball_sound)

func play_step_sound():
	var pitch = randf_range(0.9, 1.1)
	stream_playback.play_stream(step_sound,0, -19, pitch)
	
func play_landing_sound():
	stream_playback.play_stream(step_sound,0, -15)
	
