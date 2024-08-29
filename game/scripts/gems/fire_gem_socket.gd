class_name FireGemSocket extends Node2D
@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var audio_stream_player_2d = $AudioStreamPlayer2D

signal gem_placed

func _on_area_2d_area_entered(area):
	var parent = area.get_parent()
	if parent is PlayerCharacter:
		if (
			parent.current_element == "Fire" 
			and SaveGameManager.current_level_resource.collected_fire_gem
		):
			collision_shape_2d.set_deferred("disabled", true)
			animated_sprite_2d.play("collected")
			audio_stream_player_2d.play()
			gem_placed.emit()
