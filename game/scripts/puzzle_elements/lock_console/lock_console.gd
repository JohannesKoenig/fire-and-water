class_name LockConsole extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var point_light_2d = $PointLight2D
@onready var audio_stream_player_2d = $AudioStreamPlayer2D

var is_locked: bool = true:
	set(value):
		is_locked = value
		if is_locked:
			locked.emit()
		else:
			unlocked.emit()

signal unlocked
signal locked

func _ready():
	point_light_2d.energy = 0


func unlock():
	if not is_locked:
		return
	is_locked = false
	animation_player.play("unlock")
	audio_stream_player_2d.play()

func deactivate():
	if is_locked:
		return
	is_locked = true
	animation_player.play("lock")


func _on_area_2d_area_entered(area):
	var parent = area.get_parent()
	if parent is PlayerCharacter:
		var player: PlayerCharacter = parent
		if player.has_key and is_locked:
			unlock()
			player.has_key = false
