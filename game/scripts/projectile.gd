class_name Projectile extends Node2D

@onready var sprite_2d = $Sprite2D
@onready var rigid_body_2d = $Physics/RigidBody2D
@onready var physics = $Physics

@export var time_until_queue_free: float = 1
@export var time_to_live: float = 1

var target_velocity: Vector2

signal has_collided

var collision_time: float
var collided: bool = false
var can_remove_physics: bool = false

var spawn_time: float

func _ready():
	spawn_time = Time.get_unix_time_from_system()
	
	rigid_body_2d.global_position = global_position

func assemble(target_velocity: Vector2):
	self.target_velocity = target_velocity
	look_at(target_velocity)

func _process(delta):
	if not collided:
		var time_alive = Time.get_unix_time_from_system() - spawn_time
		if time_alive > time_to_live:
			collide()
	
func _physics_process(delta):
	if can_remove_physics:
		remove_physics()
	if rigid_body_2d != null:
		position = rigid_body_2d.position
	if collided:
		var delta_time = Time.get_unix_time_from_system() - collision_time
		if delta_time > time_until_queue_free:
			queue_free()
	else:
		rigid_body_2d.set_axis_velocity(self.target_velocity)

func _on_body_entered(body):
	collide()

func collide():
	if !collided:
		can_remove_physics = true
		sprite_2d.visible = false
		collided = true
		collision_time = Time.get_unix_time_from_system()
		has_collided.emit()

func remove_physics():
	physics.call_deferred("queue_free")
	can_remove_physics = false
