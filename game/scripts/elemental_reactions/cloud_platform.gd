class_name CloudPlatform extends AnimatableBody2D

@export var time_until_breaking: float = 0.2
@export var time_to_live: float = 4
@export var movement_speed: float = 10
@onready var animation_player = $AnimationPlayer


var blocked_timestamp: float
var is_blocked: bool = false
var is_fading_out: bool = false

var starting_timestamp: float

func _ready():
	starting_timestamp = Time.get_unix_time_from_system()
	animation_player.play("fade_in")

func _physics_process(delta):
	if is_fading_out:
		return
	
	if (
		(Time.get_unix_time_from_system() - starting_timestamp)
		> time_to_live
	):
		animation_player.play("fade_out")
		is_fading_out = true
		return
	
	var was_blocked = is_blocked
	is_blocked = test_move(transform, Vector2(0,-10 * delta) )
	if !is_blocked:
		position += Vector2(0,-1* movement_speed * delta)
	if !was_blocked and is_blocked:
		blocked_timestamp = Time.get_unix_time_from_system()

	if (
		is_blocked and
		(Time.get_unix_time_from_system() - blocked_timestamp)
		> time_until_breaking
	):
		animation_player.play("fade_out")
		is_fading_out = true
