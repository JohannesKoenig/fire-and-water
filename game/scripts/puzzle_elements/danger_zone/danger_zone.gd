@tool
class_name DangerZone extends Node2D

var polygon_2d: Polygon2D
var _current_points: PackedVector2Array
var fire_shader_material: Material = preload("res://resources/puzzle_elements/danger_zone/danger_zone_material.tres")
@export var element: String = "Fire"

@onready var collision_polygon_2d = $HitBox/CollisionPolygon2D
@onready var hit_box = $HitBox


func _ready():
	child_order_changed.connect(_update_polygon)
	_update_polygon()
	hit_box.element = element

func _update_polygon():
	for child in get_children():
		if child is Polygon2D:
			polygon_2d = child
			break
	if polygon_2d != null:
		polygon_2d.texture = NoiseTexture2D.new()
		match element:
			"Fire":
				polygon_2d.material = fire_shader_material
			"":
				polygon_2d.material = null
		_update_polygon_uvs()
		collision_polygon_2d.polygon = polygon_2d.polygon

func _update_polygon_uvs():
	polygon_2d.uv = polygon_2d.polygon
	_current_points = polygon_2d.polygon

func _process(delta):
	if Engine.is_editor_hint():
		if (
			polygon_2d != null 
			and _current_points != polygon_2d.polygon
		):
			_update_polygon_uvs()
		return

func _physics_process(delta):
	if Engine.is_editor_hint():
		return

func _get_configuration_warnings():
	for child in get_children():
		if child is Polygon2D:
			return []
	return ["Missing Polygon2D"]