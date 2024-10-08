class_name JumpPlayerState extends PlayerState

const SPEED = 120
const JUMP_VELOCITY = -320.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

signal jump

@export var transition_time: float = 0.3

func transition(input: InputPackage) -> String:
	if "Shoot" in input.actions:
		if not player.can_shoot_ball:
			return name
		return "Shoot"
	if has_passed(transition_time):
		return "Falling"
	return name

func on_enter(previous_state: String):
	player.velocity.y = JUMP_VELOCITY
	jump.emit()
	super(previous_state)

func update(input: InputPackage, delta: float):
	var direction = input.direction
	if direction:
		player.velocity.x = direction * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
	player.velocity.y += gravity * delta
