class_name MetaProgression extends Node2D
# The main container for the game play scenes - This is where we will manage the
# currently loaded levels and their transitions.
@onready var game_camera = $GameCamera
@onready var level_rig = $LevelRig
@onready var level_transitions = $LevelTransitions
@onready var player_packed_scene: PackedScene = preload("res://scenes/player_character.tscn")

<<<<<<< HEAD
var current_level: String

=======
var current_level_scene: Level
>>>>>>> main
var water_player: PlayerCharacter
var fire_player: PlayerCharacter

func _ready():
	current_level = level_transitions.get_first_level()
	water_player = player_packed_scene.instantiate()
	add_child(water_player)
	water_player.dead.connect(reset_level)
	water_player.set_player_id(0)
	fire_player = player_packed_scene.instantiate()
	add_child(fire_player)
	fire_player.dead.connect(reset_level)
	fire_player.set_player_id(1)
<<<<<<< HEAD
	load_level(current_level)
=======
	
	game_camera.add_player(water_player)
	game_camera.add_player(fire_player)

	var first_level_name = level_transitions.get_first_level()
	load_level(first_level_name)
>>>>>>> main

func _process(delta):
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
	level_rig.add_child(current_level_scene)
	
	var spawn_points = current_level_scene.get_spawn_points()
	water_player.position = spawn_points.water_spawn_point
	fire_player.position = spawn_points.fire_spawn_point
<<<<<<< HEAD

func reset_level():
	load_level(current_level)

=======
	
	game_camera.current_level = current_level_scene
>>>>>>> main
