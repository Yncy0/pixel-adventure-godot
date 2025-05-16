class_name State extends Node

signal change_state(new_state_name: StringName)

func enter() -> void:
	pass

func exit() -> void:
	pass

func update_input(_event: InputEvent) -> void:
	pass

func update_process(_delta: float) -> void:
	pass

func update_physics(_delta: float) -> void:
	pass
