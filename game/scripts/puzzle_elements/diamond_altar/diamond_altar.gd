class_name DiamondAltar extends Node2D

var fire_diamond_placed: bool = false
var water_diamond_placed: bool = false


func _on_water_gem_placed():
	water_diamond_placed = true
			

func _on_fire_gem_placed():
	fire_diamond_placed = true
