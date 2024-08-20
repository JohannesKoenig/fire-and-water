class_name FireBallProjectile extends Projectile

@onready var point_light_2d = $PointLight2D
@onready var gpu_particles_2d = $GPUParticles2D
@onready var line_2d = $Line2D
@onready var animation_player = $AnimationPlayer
@onready var explosion_particles = $ExplosionParticles

var collision_sound = preload("res://assets/sound_effects/player/fire_ball_collision.wav")

func time_out():
	if !collided:
		gpu_particles_2d.emitting = false
		animation_player.play("explode")
		explosion_particles.emitting = true
		super()


func collide(body):
	if !collided:
		audio_stream_player_2d.stream = collision_sound
		audio_stream_player_2d.volume_db = 30
		audio_stream_player_2d.play()
		gpu_particles_2d.emitting = false
		animation_player.play("explode")
		explosion_particles.emitting = true
		super(body)
