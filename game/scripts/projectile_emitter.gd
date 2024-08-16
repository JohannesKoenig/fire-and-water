class_name ProjectileEmitter extends Node2D


func emit_projectile(projectile: Projectile):
	get_tree().root.add_child(projectile)
	projectile.global_position = global_position

