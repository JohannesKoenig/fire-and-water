class_name GameCamera extends Camera2D

var current_level: Level
var players: Array[PlayerCharacter]
@export var shake_amplitude: float = 4
@export var shake_duration: float = 0.3
var _shake_offset: Vector2 = Vector2.ZERO

var _tween: Tween
var _shake_strength: float = 0

func _ready():
	ScreenShaker.shook.connect(shake)

func set_level(level: Level):
	current_level = level

func add_player(player: PlayerCharacter):
	players.append(player)

func _process(delta):
	var positions: Array[Vector2] = []
	for player in players:
		positions.append(player.global_position)
		
	#if current_level:
	#	positions.append(current_level.get_focus_point())
	
	var sum = positions.reduce(func(a,b): return a + b)
	var average = sum / len(positions)
	if global_position.distance_to(average) > 10:
		global_position = round(lerp(global_position,average,delta * 5))
	global_position = round(global_position + randomOffset())

func shake():
	if _tween:
		_tween.kill()
	_shake_strength = shake_amplitude
	_tween = create_tween()
	_tween.set_ease(Tween.EASE_IN_OUT)
	_tween.tween_property(self, "_shake_strength", 0.0, shake_duration)

func randomOffset() -> Vector2:
	if _shake_strength <= 0.01:
		return Vector2.ZERO
	return Vector2(randf_range(-_shake_strength, _shake_strength), randf_range(-_shake_strength, _shake_strength))
