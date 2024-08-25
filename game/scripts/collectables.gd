extends Area2D

@onready var animation_player = $AnimationPlayer


func _on_area_entered(area):
	var parent = area.get_parent()
	if parent is PlayerCharacter:
		var player: PlayerCharacter = parent
		animation_player.play("on_collection")
		player.set_key_collection()
		

	

