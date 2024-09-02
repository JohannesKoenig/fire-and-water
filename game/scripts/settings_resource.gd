class_name SettingsResource extends Resource

var volume_percentage: int = 50:
	set(value):
		volume_percentage = value
		volume_changed.emit(value)

signal volume_changed(value: int)

var brightness_percentage: int = 50:
	set(value):
		brightness_percentage = value
		brightness_changed.emit(value)

signal brightness_changed(value: int)
