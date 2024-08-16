class_name WalkPlayerState extends PlayerState


const SPEED = 120.0

func transition(input: InputPackage) -> String:
	if not player.is_on_floor():
		return "Falling"

	if "Jump" in input.actions:
		return "Jump"
	elif "Shoot" in input.actions:
		return "Shoot"
	elif name in input.actions:
		return name
	else:
		return "Idle"
	
func update(input: InputPackage, delta: float):
	var direction = input.direction
	if direction:
		player.velocity.x = direction * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
