class_name ExitVisuals extends Node2D

var model: ExitModel
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer


func accept_model(model: ExitModel):
	self.model = model

func _process(delta):
	match model.exit_state_machine.current_state:
		"Idle":
			animation_player.play("Idle")
		"TransitionToExit":
			animation_player.play("Transporting")
		"Exit":
			animation_player.play("Exit")
