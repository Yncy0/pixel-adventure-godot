class_name Player extends CharacterBody2D


@export var SPEED := 300.0
@export var JUMP_VELOCITY := -400.0
@export var JUMP_BUFFER_TIME := 0.45
@export var JUMP_COYOTE_TIME := 0.1
@export var MAX_JUMPS = 2

@onready var sprite = $AnimatedSprite2D
@onready var buffer_timer: Timer = $BufferTimer
@onready var coyote_timer: Timer = $CoyoteTimer

var direction: float

var jump_available: int = 0
var jump_buffered: bool = false
var jump_coyote: bool = false

# Basic Locomotion
func idle() -> void:
	velocity.x = move_toward(velocity.x, 0, SPEED)

func move() -> void:
	direction = Input.get_axis("left", "right")
	
	velocity.x = direction * SPEED
	
	player_flip()

func jump():
	if Input.is_action_just_pressed("jump"):
		if (is_on_floor() || jump_coyote) or (jump_available < MAX_JUMPS):
			velocity.y = JUMP_VELOCITY
			if jump_coyote:
				jump_coyote = false
				coyote_timer.stop()
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
		
	var was_on_floor = is_on_floor()
	
	# print(velocity.y)
	
	move_and_slide()
	
	if was_on_floor and !is_on_floor() and velocity.y >= 0:
		jump_coyote = true
		coyote_timer.start(JUMP_COYOTE_TIME)

func _on_buffer_timer_timeout() -> void:
	jump_buffered = false


func _on_coyote_timer_timeout() -> void:
	jump_coyote = false
