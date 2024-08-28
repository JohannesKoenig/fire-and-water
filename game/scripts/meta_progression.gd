class_name MetaProgression extends Node2D
# The main container for the game play scenes - This is where we will manage the
# currently loaded levels and their transitions.
@onready var game_camera = $GameCamera
@onready var level_rig = $LevelRig
@onready var level_transitions = $LevelTransitions
@onready var player_packed_scene: PackedScene = preload("res://scenes/player_character.tscn")
@onready var texture_rect = $CanvasLayer/TextureRect
@onready var remote_transform_2d = $GameCamera/RemoteTransform2D
@onready var current_level_resource: CurrentLevelResource = preload("res://resources/game_state/current_level_resource.tres")
@onready var scene_fader = $CanvasLayer/SceneFader
@onready var audio_stream_player = $AudioStreamPlayer
@onready var audio_animation_player = $AudioStreamPlayer/AudioAnimationPlayer
@onready var animation_player = $AnimationPlayer


@onready var current_level: String:
	set(value):
		current_level_resource.current_level = value
		current_level = value
	get:
		return current_level_resource.current_level

var current_level_scene: Level

var water_player: PlayerCharacter
var fire_player: PlayerCharacter

var reset = false

var loading_next_level = false

func _ready():
	audio_stream_player.autoplay = true
	audio_stream_player.play()
	if current_level_resource and SaveGameManager.has_savegame():
		SaveGameManager.load_savegame()
		current_level = current_level_resource.current_level
	else:
		current_level = level_transitions.get_first_level()
	water_player = player_packed_scene.instantiate()
	water_player.can_shoot_ball = SaveGameManager.current_level_resource.can_shoot_ball
	water_player.current_element = "Water"
	add_child(water_player)
	water_player.dead.connect(reset_level)
	water_player.set_player_id(0)
	fire_player = player_packed_scene.instantiate()
	add_child(fire_player)
	fire_player.dead.connect(reset_level)
	fire_player.can_shoot_ball = SaveGameManager.current_level_resource.can_shoot_ball
	fire_player.current_element = "Fire"
	fire_player.set_player_id(1)

	SaveGameManager.current_level_resource.can_shoot_ball_changed.connect(
		func(value): water_player.can_shoot_ball = value
	)
	SaveGameManager.current_level_resource.can_shoot_ball_changed.connect(
		func(value): fire_player.can_shoot_ball = value
	)

	load_level(current_level)
	texture_rect.texture = WaterViewport.get_texture()
	WaterViewport.world_2d = get_viewport().world_2d

	game_camera.add_player(water_player)
	game_camera.add_player(fire_player)
	remote_transform_2d.remote_path = "/root/WaterViewport/Camera2D"


func _process(delta):
	if Input.is_action_just_pressed("restart"):
		reset = true
	
	if reset:
		reset = false
		load_level(current_level)
	
	if current_level_scene and current_level_scene.is_finished() and not loading_next_level:
		call_deferred("load_next_level")

func load_next_level():
	loading_next_level = true
	var next_level_name = level_transitions.get_next_level(current_level_scene.level_name)[0]
	scene_fader.fade_out()
	audio_animation_player.play("fade_out")
	await scene_fader.fading_out_finished
	load_level(next_level_name)
	loading_next_level = false

func load_level(level_name: String):
	audio_stream_player.volume_db = -80.0
	var first_level_path = level_transitions.get_level_path(level_name)
	var level_scene: PackedScene = load(first_level_path)
	if current_level_scene != null:
		current_level_scene.queue_free()
	current_level_scene = level_scene.instantiate()
	current_level_scene.position = level_rig.position
	level_rig.add_child(current_level_scene)
	current_level = level_name
	SaveGameManager.write_savegame()
	
	var spawn_points = current_level_scene.get_spawn_points()
	water_player.position = spawn_points.water_spawn_point
	fire_player.position = spawn_points.fire_spawn_point
	game_camera.current_level = current_level_scene
	scene_fader.fade_in()
	audio_animation_player.play("fade_in")


func reset_level():
	deactivate_player_controls()
	scene_fader.fade_out()
	animation_player.play("player_died")
	await animation_player.animation_finished
	reset = true
	activate_player_controls()

func deactivate_player_controls():
	water_player.deactivate_input()
	fire_player.deactivate_input()

func activate_player_controls():
	water_player.activate_input()
	fire_player.activate_input()
