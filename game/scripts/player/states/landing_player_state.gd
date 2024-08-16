class_name LandingPlayerState extends PlayerState

var SPEED = 120
@export var transition_time: float = 0.1

func transition(input: InputPackage) -> String:
	if "Jump" in input.actions:
		return "Jump"
	if has_passed(transition_time):
		return "Idle"
	return name

func update(input: InputPackage, delta: float):
	var direction = input.direction
	if direction:
		player.velocity.x = direction * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
