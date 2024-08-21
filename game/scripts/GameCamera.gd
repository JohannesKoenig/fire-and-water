class_name GameCamera extends Camera2D

var current_level: Level
var players: Array[PlayerCharacter]

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
	
		
	
