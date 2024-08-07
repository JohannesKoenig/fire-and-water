class_name MetaProgression extends Node2D

@onready var level_rig = $LevelRig
@onready var level_transitions = $LevelTransitions
var current_level_scene: Level

func _ready():
	var first_level_name = level_transitions.get_first_level()
	load_level(first_level_name)

func load_level(level_name: String):
	var first_level_path = level_transitions.get_level_path(level_name)
	var level_scene: PackedScene = load(first_level_path)
	if current_level_scene != null:
		current_level_scene.queue_free()
	current_level_scene = level_scene.instantiate()
	current_level_scene.position = level_rig.position
	level_rig.add_child(current_level_scene)
