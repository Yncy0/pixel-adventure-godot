class_name EnemyBase extends CharacterBody2D

@export var _Player: Player
@export var Speed = 300.0
@export var Jump_Velocity = -400.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


var is_player: bool = false
