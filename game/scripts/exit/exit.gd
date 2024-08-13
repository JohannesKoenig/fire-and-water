class_name Exit extends Node2D

@onready var input := $Input
@onready var model := $Model
@onready var visuals = $Visuals

func _ready():
	visuals.accept_model(model)

func _process(delta: float):
	var input_package = input.get_input()
	model.update(input_package, delta)
	
