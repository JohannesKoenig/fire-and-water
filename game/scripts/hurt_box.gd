class_name HurtBox extends Area2D

@export var agent: PlayerCharacter


func _on_area_entered(area):
	if area is HitBox and area.element == agent.current_element:
		return
	agent.kill()
