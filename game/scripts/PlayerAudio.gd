class_name PlayerAudio extends AudioStreamPlayer2D

var jump_sound: AudioStream = preload("res://assets/sound_effects/player/Jump.wav")
var fire_ball_sound: AudioStream = preload("res://assets/sound_effects/player/Attack.mp3")
var water_ball_sound: AudioStream = preload("res://assets/sound_effects/player/shoot_water_ball.wav")
var step_sound: AudioStream = preload("res://assets/sound_effects/player/step.wav")
var hurt_sound: AudioStream = preload("res://assets/sound_effects/player/hurt.wav")

var _player_state_machine: PlayerStateMachine
var _player: PlayerCharacter

var stream_playback: AudioStreamPlaybackPolyphonic

func _ready():
	play()
	stream_playback = get_stream_playback()

func accept_model(player_state_machine: PlayerStateMachine):
	_player_state_machine = player_state_machine
	var shoot_state = _player_state_machine.states["Shoot"]
	shoot_state.shoot.connect(_play_elemental_ball)
	var jump_state = _player_state_machine.states["Jump"]
	jump_state.jump.connect(_play_jump_sound)

func accept_player(player: PlayerCharacter):
	_player = player
	_player.dead.connect(play_dead_sound)

func _play_jump_sound():
	var pitch = randf_range(0.9, 1.1)
	stream_playback.play_stream(jump_sound,0,10,pitch)

func _play_elemental_ball():
	match _player.current_element:
		"Fire":
			stream_playback.play_stream(fire_ball_sound, 0, 0)
		"Water":
			stream_playback.play_stream(water_ball_sound, 0, 30)

func play_step_sound():
	var pitch = randf_range(3.9, 4.1)
	stream_playback.play_stream(step_sound,0, 8, pitch)
	
func play_landing_sound():
	stream_playback.play_stream(step_sound,0, 15)

func play_dead_sound():
	stream_playback.play_stream(hurt_sound, 0, 20)
