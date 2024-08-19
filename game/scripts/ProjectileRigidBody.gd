class_name ProjectileRigidBody extends RigidBody2D

var block_collision: bool = false
var projectile: Projectile

signal collision(body: Node, ignore_processing: bool)

func _on_body_entered(body):
	if body is ProjectileRigidBody:
		body.block_collision = true
	
	collision.emit(body, block_collision)
	
	if block_collision:
		block_collision = false
		
