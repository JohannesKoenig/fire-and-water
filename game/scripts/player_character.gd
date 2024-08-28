class_name PlayerCharacter extends CharacterBody2D


@onready var player_input: PlayerInput = $PlayerInput
@onready var rig = $Rig
@onready var cojote_timer = $CojoteTimer
@onready var player_visuals = $PlayerVisuals
@onready var player_state_machine = $PlayerStateMachine
@onready var elemental_ball_projectile_emitter = $Rig/ElementalBallProjectileEmitter

var can_shoot_ball: bool = false
var has_key: bool = false
var input_active: bool = true
var has_gem: bool = false

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
	if input_active:
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
	var input_package = null
	if input_active:
		input_package = player_input.get_input()
	else:
		input_package = InputPackage.new()
		input_package.actions.append("Idle")
	player_state_machine.update(input_package, delta)
	input_package.queue_free()
	move_and_slide()
	

func set_player_id(id: int):
	player_input.player_id = id
	
func set_key_collection():
	if(has_key == false):
		has_key = true
	else: 
		has_key = false

func deactivate_input():
	input_active = false

func activate_input():
	input_active = true

func kill():
	dead.emit()
	
	
