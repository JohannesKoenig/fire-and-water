class_name SignalOrCombination extends Node

var counter: int = 0

signal on
signal off

func on_signal():
	counter += 1
	if counter == 1:
		on.emit()
		

func off_signal():
	counter -= 1
	if counter == 0:
		off.emit()
