class_name LockConsole extends Node2D

@onready var animation_player = $AnimationPlayer

var is_locked: bool = true:
	set(value):
		is_locked = value
		if locked:
			locked.emit()
		else:
			unlocked.emit()

signal unlocked
signal locked

func unlock():
	is_locked = true
	animation_player.play("unlock")

func deactivate():
	is_locked = false
	animation_player.play("lock")


func _on_area_2d_area_entered(area):
	var parent = area.get_parent()
	if parent is PlayerCharacter:
		var player: PlayerCharacter = parent
		if player.has_key:
			unlock()
			player.has_key = false
