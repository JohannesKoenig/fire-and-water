extends Node2D

@onready var audio_stream_player_2d = $AudioStreamPlayer2D


var cloud_platform = preload("res://scenes/elemental_reactions/cloud_platform.tscn")
var fire_water_projectile_collision = preload("res://assets/sound_effects/player/elemental_ball_collision.wav")

func handle_collision(elemental_collision_package: ElementalReactionPackage):
	var elements = elemental_collision_package.elements
	if "Fire" in elements and "Water" in elements:
		var instance = cloud_platform.instantiate()
		_spawn_top_level(instance)
		instance.global_position = elemental_collision_package.position
		#audio_stream_player_2d.stream = fire_water_projectile_collision
		#audio_stream_player_2d.play()
		#audio_stream_player_2d.position = elemental_collision_package.position

func _spawn_top_level(node: Node):
	get_tree().root.call_deferred("add_child",node)
