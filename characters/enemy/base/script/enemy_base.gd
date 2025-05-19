class_name EnemyBase extends CharacterBody2D

@export var _Player: Player
@export var Speed = 300.0
@export var Jump_Velocity = -400.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


var direction: float = 1.0
var is_player: bool = false


func handle_gravity(delta: float) -> void:
	if !is_on_floor():
		velocity += get_gravity() * delta 
