extends Area2D

@export var agent: PlayerCharacter


func _on_area_entered(area):
	agent.kill()
