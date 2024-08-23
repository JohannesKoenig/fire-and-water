extends Area2D




func _on_area_entered(area):
	var parent = area.get_parent()
	if parent is PlayerCharacter:
		var player: PlayerCharacter = parent
		player.set_key_collection()
	queue_free()
	

