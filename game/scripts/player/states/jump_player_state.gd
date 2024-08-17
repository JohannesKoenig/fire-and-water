class_name JumpPlayerState extends PlayerState

const SPEED = 120
const JUMP_VELOCITY = -300.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var transition_time: float = 0.3

func transition(input: InputPackage) -> String:
	if "Shoot" in input.actions:
		return "Shoot"
	if has_passed(transition_time):
		return "Falling"
	return name

func on_enter():
	player.velocity.y = JUMP_VELOCITY
	super()

func update(input: InputPackage, delta: float):
	var direction = input.direction
	if direction:
		player.velocity.x = direction * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
	player.velocity.y += gravity * delta
