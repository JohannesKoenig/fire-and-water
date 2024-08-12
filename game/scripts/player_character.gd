class_name PlayerCharacter extends CharacterBody2D



const SPEED = 120.0
const JUMP_VELOCITY = -300.0

@onready var player_input: PlayerInput = $PlayerInput
@onready var rig = $Rig

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
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if "jump" in input_package.actions and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	input_package.queue_free()

func set_player_id(id: int):
	player_input.player_id = id

func kill():
	dead.emit()
