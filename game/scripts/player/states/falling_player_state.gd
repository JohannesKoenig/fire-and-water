class_name FallingPlayerState extends PlayerState

const SPEED = 120
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player_started_on_floor: bool = false

@export var cojote_timer: float = 0.15

func transition(input: InputPackage) -> String:
	if player_started_on_floor and not has_passed(cojote_timer):
		if "Jump" in input.actions:
			return "Jump"
	if player.is_on_floor():
		return "Landing"
	return name

func on_enter():
	super()
	player_started_on_floor = player.is_on_floor()
	
func update(input: InputPackage, delta: float):
	var direction = input.direction
	if direction:
		player.velocity.x = direction * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
	player.velocity.y += gravity * delta
