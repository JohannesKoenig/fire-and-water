class_name MetaProgression extends Node2D
# The main container for the game play scenes - This is where we will manage the
# currently loaded levels and their transitions.
@onready var game_camera = $GameCamera
@onready var level_rig = $LevelRig
@onready var level_transitions = $LevelTransitions
@onready var player_packed_scene: PackedScene = preload("res://scenes/player_character.tscn")
@onready var texture_rect = $CanvasLayer/TextureRect
@onready var remote_transform_2d = $GameCamera/RemoteTransform2D


var current_level: String

var current_level_scene: Level

var water_player: PlayerCharacter
var fire_player: PlayerCharacter

var reset = false

func _ready():
	current_level = level_transitions.get_first_level()
	water_player = player_packed_scene.instantiate()
	water_player.modulate = Color.AQUA
	water_player.current_element = "Water"
	add_child(water_player)
	water_player.dead.connect(reset_level)
	water_player.set_player_id(0)
	fire_player = player_packed_scene.instantiate()
	add_child(fire_player)
	fire_player.dead.connect(reset_level)
	fire_player.set_player_id(1)

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
	
	if current_level_scene and current_level_scene.is_finished():
		var next_level_name = level_transitions.get_next_level(current_level_scene.level_name)[0]
		load_level(next_level_name)

func load_level(level_name: String):
	var first_level_path = level_transitions.get_level_path(level_name)
	var level_scene: PackedScene = load(first_level_path)
	if current_level_scene != null:
		current_level_scene.queue_free()
	current_level_scene = level_scene.instantiate()
	current_level_scene.position = level_rig.position
	# level_rig.call_deferred("add_child", current_level_scene)
	level_rig.add_child(current_level_scene)
	current_level = level_name
	
	var spawn_points = current_level_scene.get_spawn_points()
	water_player.position = spawn_points.water_spawn_point
	fire_player.position = spawn_points.fire_spawn_point
	game_camera.current_level = current_level_scene


func reset_level():
	reset = true

