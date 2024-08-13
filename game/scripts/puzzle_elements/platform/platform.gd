class_name Platform extends AnimatableBody2D

@export var path: Path2D
@export var duration: float = 4
var time: float
var forward: bool = false

var _curve: Curve2D
var _curve_length: float

var start_position: Vector2

func _ready():
	start_position = position
	_curve = path.get_curve()
	_curve_length = _curve.get_baked_length()
	time = Time.get_unix_time_from_system()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Time.get_unix_time_from_system() - time > duration:
		time = Time.get_unix_time_from_system()
		forward = !forward

	var curve_offset = _get_offset()
	var current_position = _curve.sample_baked(curve_offset)
	position = current_position + start_position

func _get_offset() -> float:
	var current_time = Time.get_unix_time_from_system()
	var movement_duration = current_time - time
	var percentage = movement_duration / duration
	var curve_progress = _curve_length * percentage
	if forward:
		return curve_progress
	else:
		return _curve_length - (curve_progress)
	
