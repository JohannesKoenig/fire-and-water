class_name WhiteSpirit extends Node2D

@onready var texture_rect = $TextureRect
@onready var audio_stream_player_2d = $AudioStreamPlayer2D


func _ready():
	texture_rect.scale = Vector2.ZERO
	audio_stream_player_2d.volume_db = 0
	
