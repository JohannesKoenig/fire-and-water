class_name ExitModel extends Node2D

@onready var exit_state_machine = $ExitStateMachine


func update(input_package: ExitInputPackage, delta: float):
	exit_state_machine.update(input_package, delta)

