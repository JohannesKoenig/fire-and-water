class_name ProjectileEmitter extends Node2D


func emit_projectile(projectile: Projectile, element: String):
	projectile.global_position = global_position
	if element == "Water":
		WaterViewport.add_child(projectile)
	else:
		get_tree().root.add_child(projectile)

