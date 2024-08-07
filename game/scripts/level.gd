@tool
class_name Level extends Node2D
# add a finishCondition 

@export var level_name: String
@onready var fire_spawn_point = $FireSpawnPoint
@onready var water_spawn_point = $WaterSpawnPoint
@onready var placeholder = $Placeholder

var finish_condition

# should be called once a level's finish-condition is met
signal exit_level

func _ready():
	var spawn_point_package = get_spawn_points()
	for child in get_children():
		if child is FinishCondition:
			finish_condition = child
			break
	placeholder.text = level_name

func _process(delta):
	if finish_condition.is_finished():
		exit_level.emit()

func get_spawn_points() -> SpawnPointPackage:
	return SpawnPointPackage.constructor(
		fire_spawn_point.position,
		water_spawn_point.position
	)

func _get_configuration_warnings():
	for child in get_children():
		if child is FinishCondition:
			return []
	return ["Missing FinishCondition"]
