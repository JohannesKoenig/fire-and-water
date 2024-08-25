class_name BobbingComponent extends Node

@export var x_displacement: float = -4
@export var duration: float = 1

var active = true

var tween: Tween
var _parent: Node2D
var _start_position: Vector2

func _ready():
	_parent = get_parent()
	_start_position = _parent.position
	tween_position()
	

func _process(delta):
	if Engine.is_editor_hint():
		if _parent != get_parent():
			_parent.position = _start_position
			_parent = get_parent()
			tween_position()
		return


func tween_position():
	if tween:
		tween.kill()
	if not active:
		return
	tween = create_tween().set_ease(
		Tween.EASE_IN_OUT
	)
	tween.tween_property(
		_parent,
		"position",
		_start_position + Vector2(0, x_displacement),
		duration
	)
	tween.chain().tween_property(
		_parent,
		"position",
		_start_position,
		duration
	)
	tween.finished.connect(tween_position)
	tween.play()
		

func activate():
	active = true
	tween_position()

func deactivate():
	active = false
