class_name BallSkillRuneEffect extends SkillRuneEffect

func execute(player: PlayerCharacter):
	SaveGameManager.current_level_resource.can_shoot_ball = true
