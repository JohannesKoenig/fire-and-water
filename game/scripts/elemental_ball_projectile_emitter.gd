class_name ElementalBallProjectileEmitter extends ProjectileEmitter

@onready var fire_ball_projectile = preload("res://scenes/fire_ball_projectile.tscn")
@onready var water_ball_projectile = preload("res://scenes/water_ball_projectile.tscn")

func emit_elemental_ball(element: String, target_velocity: Vector2):
	var projectile: Projectile = null
	match element:
		"Fire":
			projectile = fire_ball_projectile.instantiate()
		"Water":
			projectile = water_ball_projectile.instantiate()
	if projectile != null:
		projectile.assemble(target_velocity)
		emit_projectile(projectile, element)

