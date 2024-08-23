class_name PlayerCharacter extends CharacterBody2D

@onready var player_input: PlayerInput = $PlayerInput
@onready var rig = $Rig
@onready var cojote_timer = $CojoteTimer
@onready var player_visuals = $PlayerVisuals
@onready var player_state_machine = $PlayerStateMachine
@onready var elemental_ball_projectile_emitter = $Rig/ElementalBallProjectileEmitter

var has_key: bool = false

@export var current_element: String = "Fire":
	set(value):
		current_element = value
		element_changed.emit(value)
signal element_changed(new_element: String)

signal dead

func _ready():
	player_visuals.accept_model(player_state_machine)
	player_visuals.accept_player(self)
	player_state_machine.accept_player(self)

func _process(delta):
	var input_package = player_input.get_input()
	var direction = input_package.direction
	if direction > 0:
		rig.facing_right = true
		rig.scale.x = 1
	elif direction < 0:
		rig.facing_right = false
		rig.scale.x = -1
	input_package.queue_free()

func _physics_process(delta):
	var input_package = player_input.get_input()
	player_state_machine.update(input_package, delta)
	move_and_slide()
	input_package.queue_free()

func set_player_id(id: int):
	player_input.player_id = id

func kill():
	dead.emit()
