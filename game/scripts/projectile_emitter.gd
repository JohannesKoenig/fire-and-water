class_name ProjectileEmitter extends Node2D


func emit_projectile(projectile: Projectile):
	projectile.global_position = global_position
	get_tree().root.add_child(projectile)

