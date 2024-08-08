class_name ExitStateMachine extends Node


var states: Dictionary = {}
var current_state: String
var starting_state: String = "Idle"


func _ready():
	current_state = starting_state
	for child in get_children():
		if child is ExitState:
			states[child.name] = child


func update(input_package: ExitInputPackage, delta: float):
	switch_state(input_package)
	var current_state_node: ExitState = states[current_state]
	current_state_node.update(input_package, delta)


func switch_state(input_package: ExitInputPackage):
	var current_state_node: ExitState = states[current_state]
	var next_state = current_state_node.transition(input_package)
	if next_state == current_state:
		return
	print(next_state)
	current_state_node.exit_state()
	current_state = next_state
	var next_state_node: ExitState = states[next_state]
	next_state_node.enter_state()
