extends Node
class_name State

signal Transitioned

func Enter() -> void:
	pass
	
func Exit() -> void:
	pass
	
func Update(_delta: float) -> void:
	pass

## This is a physics process.
func Physics_Process(delta: float) -> void:
	pass
