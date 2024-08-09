extends Node2D

@export var rig: Rig
@onready var animated_sprite_2d = $AnimatedSprite2D

@export var player_input : PlayerInput


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input_package = player_input.get_input()
	var direction = input_package.direction
	
	if rig.facing_right: 
		scale.x = 1
	else: 
		scale.x = -1
		
	if direction == 0:
		animated_sprite_2d.play("idle")
	else: 
		animated_sprite_2d.play("walk")
	input_package.queue_free()
