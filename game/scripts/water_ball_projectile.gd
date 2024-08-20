class_name WaterBallProjectile extends Projectile

@onready var water = $Water
@onready var small_dropplets = $SmallDropplets
@onready var animation_player = $AnimationPlayer
@onready var explosion_particles = $ExplosionParticles


func time_out():
	if !collided:
		water.emitting = false
		animation_player.play("explode")
		small_dropplets.emitting = false
		explosion_particles.emitting = true
		super()

func collide(body):
	if !collided:
		water.emitting = false
		animation_player.play("explode")
		small_dropplets.emitting = false
		explosion_particles.emitting = true
		super(body)
