class_name SettingsMenu extends Control

@onready var settings_resource: SettingsResource = preload("res://resources/settings_resource.tres")
@onready var h_slider = $CenterContainer/VBoxContainer/HBoxContainer/HSlider
@onready var label = $CenterContainer/VBoxContainer/HBoxContainer/Label2
@onready var brightness_h_slider = $CenterContainer/VBoxContainer/HBoxContainer2/HSlider
@onready var brightness_label = $CenterContainer/VBoxContainer/HBoxContainer2/Label2


@export var min_master_volume: float = -30.0
@export var max_master_volume: float = 10.0
var audio_bus: AudioBusLayout

@onready var _master_bus := AudioServer.get_bus_index("Master")

# Called when the node enters the scene tree for the first time.
func _ready():
	settings_resource.volume_changed.connect(update_slider)
	settings_resource.volume_changed.connect(update_label)
	settings_resource.volume_changed.connect(update_volume)
	update_slider(settings_resource.volume_percentage)
	update_label(settings_resource.volume_percentage)
	update_volume(settings_resource.volume_percentage)

	settings_resource.brightness_changed.connect(update_brightness_slider)
	settings_resource.brightness_changed.connect(update_brightness_label)
	update_brightness_slider(settings_resource.brightness_percentage)
	update_brightness_label(settings_resource.brightness_percentage)

func update_slider(value: int):
	h_slider.value = value

func update_label(value: int):
	if value < 100:
		label.text = " " + str(value) + "%"
	else:
		label.text = str(value) + "%"

func _on_h_slider_value_changed(value):
	if settings_resource.volume_percentage != value:
		settings_resource.volume_percentage = value

func _on_save_button_pressed():
	SettingsManager.write_savegame()
	visible = false


func update_volume(value: int):
	var decible = float(value)/100 * (max_master_volume - min_master_volume) + min_master_volume
	AudioServer.set_bus_volume_db(_master_bus, decible)


func _on_brightness_h_slider_value_changed(value):
	if settings_resource.brightness_percentage != value:
		settings_resource.brightness_percentage = value

func update_brightness_slider(value: int):
	brightness_h_slider.value = value
	
func update_brightness_label(value: int):
	if value < 100:
		brightness_label.text = " " + str(value) + "%"
	else:
		brightness_label.text = str(value) + "%"
