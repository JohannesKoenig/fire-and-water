class_name Projectile extends Node2D

@onready var sprite_2d = $Sprite2D
@onready var projectile_rigid_body = $Physics/ProjectileRigidBody
@onready var physics = $Physics
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D


@export var time_until_queue_free: float = 1
@export var time_to_live: float = 1
@export var element: String

var target_velocity: Vector2

signal has_collided

var collision_time: float
var collided: bool = false
var can_remove_physics: bool = false

var spawn_time: float

func _ready():
	spawn_time = Time.get_unix_time_from_system()
	
	projectile_rigid_body.global_position = global_position
	projectile_rigid_body.projectile = self

func assemble(target_velocity: Vector2):
	self.target_velocity = target_velocity
	look_at(target_velocity)

func _process(delta):
	if not collided:
		var time_alive = Time.get_unix_time_from_system() - spawn_time
		if time_alive > time_to_live:
			time_out()
	
func _physics_process(delta):
	if can_remove_physics:
		remove_physics()
	if projectile_rigid_body != null:
		position = projectile_rigid_body.position
	if collided:
		var delta_time = Time.get_unix_time_from_system() - collision_time
		if delta_time > time_until_queue_free:
			queue_free()
	else:
		projectile_rigid_body.set_axis_velocity(self.target_velocity)


func time_out():
	if !collided:
		can_remove_physics = true
		sprite_2d.visible = false
		collided = true
		collision_time = Time.get_unix_time_from_system()
		has_collided.emit()

func collide(body):
	if !collided:
		ScreenShaker.shake()
		can_remove_physics = true
		sprite_2d.visible = false
		collided = true
		collision_time = Time.get_unix_time_from_system()
		has_collided.emit()

func propagate_collision(body):
	if body is ProjectileRigidBody:
		var projectile = body.projectile
		var elemental_reaction_package = ElementalReactionPackage.new()
		elemental_reaction_package.elements.append(element)
		elemental_reaction_package.elements.append(projectile.element)
		elemental_reaction_package.position = (
			(global_position + projectile.global_position) / 2
		)
		ElementalReactions.handle_collision(elemental_reaction_package)
		elemental_reaction_package.queue_free()
		
func remove_physics():
	physics.call_deferred("queue_free")
	can_remove_physics = false

func _on_projectile_rigid_body_collision(body, ignore_processing: bool):
	if not ignore_processing:
		propagate_collision(body)
	collide(body)
