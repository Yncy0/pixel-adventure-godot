class_name EnemyBase extends CharacterBody2D


@export var Speed = 300.0
@export var Jump_Velocity = -400.0


func _physics_process(delta: float) -> void:
	move_and_slide()
