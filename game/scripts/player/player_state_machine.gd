class_name PlayerStateMachine extends Node

var states: Dictionary = {}
var current_state: String = "Idle"
var _player: PlayerCharacter

func accept_player(player: PlayerCharacter):
	_player = player
	for state in states.keys():
		states[state].player = player

func _ready():
	for child in get_children():
		if child is PlayerState:
			states[child.name] = child
			

func update(input: InputPackage, delta: float):
	transition(input)
	states[current_state].update(input, delta)

func transition(input: InputPackage):
	var current_state_node = states[current_state]
	var next_state = current_state_node.transition(input)
	if next_state != current_state:
		var next_state_node = states[next_state]
		current_state_node.on_exit()
		next_state_node.on_enter()
		current_state = next_state
