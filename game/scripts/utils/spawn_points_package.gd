class_name SpawnPointPackage extends Node

var fire_spawn_point: Vector2
var water_spawn_point: Vector2

static func constructor(fire_spawn_point: Vector2, water_spawn_point: Vector2):
	var package = SpawnPointPackage.new()
	package.fire_spawn_point = fire_spawn_point
	package.water_spawn_point = water_spawn_point
	return package
