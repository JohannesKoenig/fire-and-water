class_name Trail2D extends Line2D

@export var length: int = 30


func _process(delta):
	global_position = Vector2.ZERO
	global_rotation = 0
	add_point(get_parent().global_position)
	while get_point_count() > length:
		remove_point(0)

