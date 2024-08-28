class_name AudioBusMixer extends Node

@export var player_bus_volume: float = 0.0
var audio_bus: AudioBusLayout

@onready var _player_bus := AudioServer.get_bus_index("player")


func _ready() -> void:
	AudioServer.set_bus_volume_db(_player_bus, player_bus_volume)

func _process(delta):
	AudioServer.set_bus_volume_db(_player_bus, player_bus_volume)
