@tool
class_name Torch extends Node2D

@export var energy: float = 2.5
@export var texture_scale: float = 2
@export var flicker_duration: float = 0.2

@onready var point_light_2d = $PointLight2D
@onready var animated_sprite_2d = $AnimatedSprite2D


var tween: Tween

func _ready():
	animated_sprite_2d.frame = randi_range(0, 10)
	tween_scale()
	animated_sprite_2d.play("default")
	if Engine.is_editor_hint():
		return

func _process(delta):
	if Engine.is_editor_hint():
		point_light_2d.energy = energy
		return

func _physics_process(delta):
	if Engine.is_editor_hint():
		return

func tween_scale():
	if tween:
		tween.kill()
	tween = create_tween().set_ease(
		Tween.EASE_IN_OUT
	)
	tween.tween_property(
		point_light_2d,
		"texture_scale",
		texture_scale * randf_range(0.8, 1.2),
		flicker_duration * randf_range(0.3, 1.2)
	)
	tween.finished.connect(tween_scale)
	tween.play()
		
