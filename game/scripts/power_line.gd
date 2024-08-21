@tool
class_name PowerLine extends Line2D

@export var glowing_color: Color
@export var background_color: Color
@export var active: bool = false:
	set(value):
		active = value
		if active:
			material.set_shader_parameter("GlowingColor", glowing_color)
			material.set_shader_parameter("BackgroundColor", lerp(glowing_color, background_color, 0.9))
		else:
			material.set_shader_parameter("GlowingColor", background_color)
			material.set_shader_parameter("BackgroundColor", background_color)
			
func _ready():
	if active:
		material.set_shader_parameter("GlowingColor", glowing_color)
		material.set_shader_parameter("BackgroundColor", lerp(glowing_color, background_color, 0.2))
	else:
		material.set_shader_parameter("GlowingColor", background_color)
		material.set_shader_parameter("BackgroundColor", background_color)


func activate():
	active = true

func deactivate():
	active = false
