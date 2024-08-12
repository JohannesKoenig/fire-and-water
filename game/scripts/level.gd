@tool
class_name Level extends Node2D

@export var level_name: String

@onready var fire_spawn_point = $FireSpawnPoint
@onready var water_spawn_point = $WaterSpawnPoint
@onready var placeholder = $Placeholder
@onready var focus_point = $FocusPoint

var finish_condition: FinishCondition

func _ready():
	for child in get_children():
		if child is FinishCondition:
			finish_condition = child
			break
	placeholder.text = level_name

func _process(delta):
	if Engine.is_editor_hint():
		return

func _physics_process(delta):
	if Engine.is_editor_hint():
		return

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

func is_finished() -> bool:
	if finish_condition and finish_condition.is_satisfied():
		return true
	else:
		return false

func get_focus_point() -> Vector2:
	return focus_point.global_position
