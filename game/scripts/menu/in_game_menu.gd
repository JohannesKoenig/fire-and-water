extends Control

@onready var continue_button = $CenterContainer/VBoxContainer/ContinueButton
@onready var label = $Label
@onready var current_level_resource = preload("res://resources/game_state/current_level_resource.tres")
@onready var settings_menu = $SettingsMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	continue_button.grab_focus()
	current_level_resource.tries_changed.connect(update_death_counter)
	update_death_counter(current_level_resource.tries)

func open():
	visible = true

func close():
	visible = false

func exit_to_menu():
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")

func update_death_counter(value: int):
	label.text = str(value) + " Deaths"

func _on_settings_button_pressed():
	settings_menu.visible = true
