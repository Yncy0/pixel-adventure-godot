class_name Birb extends EnemyBase


@export var Fly_Time: float = 1.0

@onready var fly_timer: Timer = $FlyTimer

var start_y_pos: float 
var direction: float = -1.00

enum STATES {
	FLY,
}

var state: STATES = STATES.FLY

var sprite_y_offsets = {
	0: 0.0,
	1: -2.0,
	2: -2.0,
	3: -4.0,
	4: -10.0,
	5: -5.0,
	6: -3.0,
	7: 0.0
}

func _ready() -> void:
	fly_timer.start(Fly_Time)
	start_y_pos = position.y


func handle_state() -> void:
	match state:
		STATES.FLY:
			fly()
			sprite.play("fly")


func set_state(new_state: STATES) -> void:
	if new_state == state:
		return
	
	state = new_state


func fly() -> void:
	velocity.x = direction * Speed


func sprite_flip() -> void:
	if direction < 0:
		sprite.flip_h = false
	elif direction > 0:
		sprite.flip_h = true


func _physics_process(_delta: float) -> void:
	handle_state()
	sprite_flip()
	
	move_and_slide()


func _on_fly_timer_timeout() -> void:
	if direction == -1.0:
		direction = 1.0
	elif direction == 1.0:
		direction = -1.0
	
	fly_timer.start(Fly_Time)


func _on_animated_sprite_2d_frame_changed() -> void:
	var current_frame = sprite.frame
	var y_offset = sprite_y_offsets.get(current_frame, 0.0)
	position.y = start_y_pos + y_offset
