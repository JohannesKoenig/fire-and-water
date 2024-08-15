class_name JumpPlayerState extends PlayerState

const SPEED = 120
const JUMP_VELOCITY = -300.0

@export var transition_time: float = 0.3

func transition(input: InputPackage) -> String:
	if has_passed(transition_time):
		return "Falling"
	return name

func on_enter():
	player.velocity.y = JUMP_VELOCITY

func update(input: InputPackage, delta: float):
	var direction = input.direction
	if direction:
		player.velocity.x = direction * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
