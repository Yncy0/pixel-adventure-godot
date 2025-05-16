class_name Player extends CharacterBody2D


@export var SPEED := 300.0
@export var JUMP_VELOCITY := -400.0
@export var JUMP_BUFFER_TIME := 0.45

@onready var sprite = $AnimatedSprite2D
@onready var buffer_timer: Timer = $BufferTimer

var direction: float

var is_jump_available: bool = true
var jump_buffered: bool = false

# Basic Locomotion
func idle() -> void:
	velocity.x = move_toward(velocity.x, 0, SPEED)

func move() -> void:
	direction = Input.get_axis("left", "right")
	
	velocity.x = direction * SPEED
	
	player_flip()

func jump():
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		else:
			if !jump_buffered:
				jump_buffered = true
				buffer_timer.start()

# Actions when character flip
func player_flip() -> void:
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	
	move_and_slide()


func _on_buffer_timer_timeout() -> void:
	jump_buffered = false
