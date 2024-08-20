extends Node2D

var cloud_platform = preload("res://scenes/elemental_reactions/cloud_platform.tscn")

func handle_collision(elemental_collision_package: ElementalReactionPackage):
	var elements = elemental_collision_package.elements
	if "Fire" in elements and "Water" in elements:
		var instance = cloud_platform.instantiate()
		_spawn_top_level(instance)
		instance.global_position = elemental_collision_package.position

func _spawn_top_level(node: Node):
	get_tree().root.call_deferred("add_child",node)
