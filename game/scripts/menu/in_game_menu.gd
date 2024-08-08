extends Control

@onready var continue_button = $CenterContainer/VBoxContainer/ContinueButton

# Called when the node enters the scene tree for the first time.
func _ready():
	continue_button.grab_focus()

func open():
	visible = true

func close():
	visible = false

func exit_to_menu():
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
