class_name IdlePlayerState extends PlayerState


func transition(input: InputPackage) -> String:
	if not player.is_on_floor():
		return "Falling"
	if "Jump" in input.actions:
		return "Jump"
	if "Walk" in input.actions:
		return "Walk"
	if "Shoot" in input.actions:
		return "Shoot"
	return name

func on_enter():
	player.velocity = Vector2.ZERO
