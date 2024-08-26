class_name DiamondAltarFinishCondition extends FinishCondition

@export var diamond_altar: DiamondAltar

func is_satisfied() -> bool:
	return diamond_altar.fire_diamond_placed and diamond_altar.water_diamond_placed
