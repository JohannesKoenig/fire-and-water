class_name ElementalBallProjectileEmitter extends ProjectileEmitter

@onready var fire_ball_projectile = preload("res://scenes/fire_ball_projectile.tscn")

func emit_elemental_ball(element: String, target_velocity: Vector2):
	match element:
		"Fire":
			var projectile = fire_ball_projectile.instantiate()
			projectile.assemble(target_velocity)
			emit_projectile(projectile)

