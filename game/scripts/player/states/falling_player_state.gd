class_name FallingPlayerState extends PlayerState

const SPEED = 120
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player_started_from_jump: bool = false

@export var cojote_timer: float = 0.15

func transition(input: InputPackage) -> String:
	if not player_started_from_jump and not has_passed(cojote_timer):
		if "Jump" in input.actions:
			return "Jump"
	if "Shoot" in input.actions:
		if not player.can_shoot_ball:
			return name
		return "Shoot"
	if player.is_on_floor():
		return "Landing"
	return name

func on_enter(previous_state: String):
	super(previous_state)
	if previous_state != "Jump":
		player_started_from_jump = false
	else:
		player_started_from_jump = true
	
func update(input: InputPackage, delta: float):
	var direction = input.direction
	if direction:
		player.velocity.x = direction * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
	player.velocity.y += gravity * delta
