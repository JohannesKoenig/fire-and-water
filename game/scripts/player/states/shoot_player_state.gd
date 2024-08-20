class_name ShootPlayerState extends PlayerState

const SPEED: float = 120.0
const FIRE_PROJECTILE_VELOCITY: float = 220.0
const WATER_PROJECTILE_VELOCITY: float = 120.0


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var transition_time: float = 0.5
@export var shooting_delay: float = 0.2

var has_shot: bool = false

func transition(input: InputPackage) -> String:
	if has_passed(transition_time):
		if player.is_on_floor():
			return "Idle"
		else:
			return "Falling"
	return name

func on_enter():
	has_shot = false
	super()

func update(input: InputPackage, delta: float):
	if has_passed(shooting_delay) and not has_shot:
		var projectile_direction = Vector2.LEFT
		if player.rig.facing_right:
			projectile_direction = Vector2.RIGHT
		var projectile_velocity: Vector2 = projectile_direction
		match player.current_element:
			"Fire":
				projectile_velocity *= FIRE_PROJECTILE_VELOCITY
			"Water":
				projectile_velocity *= WATER_PROJECTILE_VELOCITY
		player.elemental_ball_projectile_emitter.emit_elemental_ball(
			player.current_element, projectile_velocity
		)
		has_shot = true
	var direction = input.direction
	if direction:
		player.velocity.x = direction * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
	player.velocity.y += gravity * delta
