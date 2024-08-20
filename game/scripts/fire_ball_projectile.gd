class_name FireBallProjectile extends Projectile

@onready var point_light_2d = $PointLight2D
@onready var gpu_particles_2d = $GPUParticles2D
@onready var line_2d = $Line2D
@onready var animation_player = $AnimationPlayer
@onready var explosion_particles = $ExplosionParticles


func time_out():
	if !collided:
		gpu_particles_2d.emitting = false
		animation_player.play("explode")
		explosion_particles.emitting = true
		super()


func collide(body):
	if !collided:
		gpu_particles_2d.emitting = false
		animation_player.play("explode")
		explosion_particles.emitting = true
		super(body)
