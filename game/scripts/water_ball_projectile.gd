class_name WaterBallProjectile extends Projectile

@onready var water = $Water
@onready var small_dropplets = $SmallDropplets
@onready var animation_player = $AnimationPlayer
@onready var explosion_particles = $ExplosionParticles

var collision_sound = preload("res://assets/sound_effects/player/elemental_ball_collision.wav")


func time_out():
	if !collided:
		water.emitting = false
		animation_player.play("explode")
		small_dropplets.emitting = false
		explosion_particles.emitting = true
		super()

func collide(body):
	if !collided:
		audio_stream_player_2d.stream = collision_sound
		audio_stream_player_2d.volume_db = 15
		audio_stream_player_2d.play()
		water.emitting = false
		animation_player.play("explode")
		small_dropplets.emitting = false
		explosion_particles.emitting = true
		super(body)
