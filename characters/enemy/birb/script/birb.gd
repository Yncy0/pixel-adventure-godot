class_name Birb extends EnemyBase


@export var Fly_Time: float = 1.0

@onready var fly_timer: Timer = $FlyTimer

var reset_pos = position.x - position.x
var direction: float = -1.0

enum STATES {
	FLY,
}

var state: STATES = STATES.FLY


func handle_state() -> void:
	match state:
		STATES.FLY:
			fly()
			sprite.play("fly")


func set_state(new_state: STATES) -> void:
	if new_state == state:
		return
	
	state = new_state


func _ready() -> void:
	fly_timer.start(Fly_Time)


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
