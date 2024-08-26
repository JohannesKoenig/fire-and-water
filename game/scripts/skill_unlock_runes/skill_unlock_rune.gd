@tool
class_name SkillUnlockRune extends Node2D

var skill_rune_effect: SkillRuneEffect
@onready var animation_player = $AnimationPlayer
@onready var collision_shape_2d = $Area2D/CollisionShape2D

signal activated


func _ready():
	for child in get_children():
		if child is SkillRuneEffect:
			skill_rune_effect = child
			break

func _on_area_2d_area_entered(area):
	var parent = area.get_parent()
	if parent is PlayerCharacter:
		skill_rune_effect.execute(parent)
		animation_player.play("unlock")
		collision_shape_2d.set_deferred("disabled", true)
		activated.emit()

func _process(delta):
	if Engine.is_editor_hint():
		if skill_rune_effect == null:
			for child in get_children():
				if child is SkillRuneEffect:
					skill_rune_effect = child
					break
		return

func _get_configuration_warnings():
	if skill_rune_effect == null:
		return ["Missing SkillRuneEffect"]
	else:
		return []
