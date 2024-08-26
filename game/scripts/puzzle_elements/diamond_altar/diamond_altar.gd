class_name DiamondAltar extends Node2D

var fire_diamond_placed: bool = false
var water_diamond_placed: bool = false
@onready var water_collision_shape_2d = $WaterDiamondArea/CollisionShape2D
@onready var fire_collision_shape_2d = $FireDiamondArea/CollisionShape2D
@onready var animation_player = $AnimationPlayer


func _on_water_diamond_area_area_entered(area):
	var parent = area.get_parent()
	if parent is PlayerCharacter:
		if parent.current_element == "Water":
			water_diamond_placed = true
			water_collision_shape_2d.disabled = true
			animation_player.play("place_water_diamond")

func _on_fire_diamond_area_area_entered(area):
	var parent = area.get_parent()
	if parent is PlayerCharacter:
		if parent.current_element == "Fire":
			fire_diamond_placed = true
			fire_collision_shape_2d.disabled = true
			animation_player.play("place_fire_diamond")
