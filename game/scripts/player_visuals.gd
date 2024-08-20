extends Node2D

@onready var point_light_2d = $PointLight2D
@onready var fire_sprite_frames = preload("res://resources/player_sprite_frames_fire.tres")
@onready var water_sprite_frames = preload("res://resources/player_sprite_frames_water.tres")
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var player_audio = $PlayerAudio

@export var rig: Rig
@export var player_input : PlayerInput

var _player_state_machine: PlayerStateMachine
var _player: PlayerCharacter

func accept_model(player_state_machine: PlayerStateMachine):
	_player_state_machine = player_state_machine
	player_audio.accept_model(player_state_machine)

func accept_player(player: PlayerCharacter):
	_player = player
	player.element_changed.connect(update_element)
	update_element(player.current_element)

func _process(delta):
	var input_package = player_input.get_input()
	var direction = input_package.direction
	
	if rig.facing_right: 
		scale.x = 1
	else: 
		scale.x = -1
		
	animated_sprite_2d.play(_player_state_machine.current_state)
	
	input_package.queue_free()

func update_element(element: String):
	print("element")
	match element:
		"Fire":
			animated_sprite_2d.sprite_frames = fire_sprite_frames
			point_light_2d.color = Color.ORANGE
		"Water":
			animated_sprite_2d.sprite_frames = water_sprite_frames
			point_light_2d.color = Color.AQUA
			
