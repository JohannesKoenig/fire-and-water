class_name PlayerCharacter extends CharacterBody2D



const SPEED = 120.0
const JUMP_VELOCITY = -300.0

@onready var player_input: PlayerInput = $PlayerInput
@onready var rig = $Rig
@onready var cojote_timer = $CojoteTimer

var was_on_floor: bool
var jumping: bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

signal dead

func _process(delta):
	var input_package = player_input.get_input()
	var direction = input_package.direction
	if direction > 0:
		rig.facing_right = true
	elif direction < 0:
		rig.facing_right = false
	input_package.queue_free()

func _physics_process(delta):
	var input_package = player_input.get_input()
	var direction = input_package.direction
	if is_on_floor():
		jumping = false
	# Add the gravity.
	if was_on_floor != is_on_floor():
		cojote_timer.start()
	
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if "jump" in input_package.actions and can_jump():
		jumping = true
		cojote_timer.stop()
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	was_on_floor = is_on_floor()
	move_and_slide()
	
	input_package.queue_free()

func set_player_id(id: int):
	player_input.player_id = id

func kill():
	dead.emit()

func can_jump() -> bool:
	return is_on_floor() or not cojote_timer.is_stopped() and not jumping
