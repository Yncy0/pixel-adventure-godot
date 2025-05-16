class_name Player extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0

@onready var sprite = $AnimatedSprite2D

var direction: float

# Basic Locomotion
func idle() -> void:
	velocity.x = move_toward(velocity.x, 0, SPEED)

func move() -> void:
	direction = Input.get_axis("left", "right")
	
	velocity.x = direction * SPEED
	
	player_flip()

func jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

# Actions when character flip
func player_flip() -> void:
	if direction > 0:
		sprite.flip_h = false
	if direction < 0:
		sprite.flip_h = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	move_and_slide()
