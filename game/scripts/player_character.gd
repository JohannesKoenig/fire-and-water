extends CharacterBody2D



const SPEED = 120.0
const JUMP_VELOCITY = -300.0


@onready var rig = $Rig

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _process(delta):
	var direction = Input.get_axis("left", "right")
	if direction > 0:
		rig.facing_right = true
	elif direction < 0:
		rig.facing_right = false

func _physics_process(delta):
	
	var direction = Input.get_axis("left", "right")
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
