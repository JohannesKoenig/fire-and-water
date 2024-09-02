extends WorldEnvironment

@onready var settings_resource: SettingsResource = preload("res://resources/settings_resource.tres")
@onready var env = preload("res://resources/environment.tres")
# Called when the node enters the scene tree for the first time.
func _ready():
	settings_resource.brightness_changed.connect(update_brightness)
	environment = env
	update_brightness(settings_resource.brightness_percentage)

func update_brightness(value: int):
	var min_value = 0.5
	var max_value = 1.5
	var brightness = (float(value) / 100) * (max_value - min_value) + min_value
	environment.adjustment_brightness = brightness
