class_name WaterGem extends Node2D
@onready var animation_player = $AnimationPlayer
@onready var collision_shape_2d = $Area2D/CollisionShape2D

signal picked_up

func _on_area_2d_area_entered(area):
	var parent = area.get_parent()
	if parent is PlayerCharacter:
		if parent.current_element == "Water":
			parent.has_gem = true
			animation_player.play("collect")
			collision_shape_2d.set_deferred("disabled", true)
			SaveGameManager.current_level_resource.collected_water_gem = true
			picked_up.emit()
