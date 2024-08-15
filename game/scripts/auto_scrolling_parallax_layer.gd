class_name AutoScrollingParallaxLayer extends ParallaxLayer

@export var velocity: Vector2
# only works for positive scrolling directions

func _process(delta):
	motion_offset += velocity * delta
	if motion_offset.x >= motion_mirroring.x:
		motion_offset.x -= motion_mirroring.x
	if motion_offset.y >= motion_mirroring.y:
		motion_offset.y -= motion_mirroring.y
