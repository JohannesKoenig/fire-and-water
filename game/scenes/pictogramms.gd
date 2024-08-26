extends Node2D

@onready var area_2d = $Area2D

var counter : int = 0

func _ready():
	modulate = Color.BLACK

func _on_area_2d_area_entered(area):
	counter = counter + 1
	modulate = Color.AQUA


func _on_area_2d_area_exited(area):
	counter = counter - 1
	if counter  == 0: 
		modulate = Color.BLACK
	else:
		pass
