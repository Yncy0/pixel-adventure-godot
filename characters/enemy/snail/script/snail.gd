class_name Snail extends EnemyBase


@onready var ray_cast_wall: RayCast2D = $RayCastWall
@onready var ray_cast_floor: RayCast2D = $RayCastFloor


var shell_mode: bool = false : set = set_shell_mode

enum STATES {
	IDLE,
	WALK,
	SHELL_IDLE,
	SHELL_HIT
}

var state: STATES = STATES.WALK


func handle_states() -> void:
	match state:
		STATES.IDLE:
			idle()
		STATES.WALK:
			walk()
			sprite.play("walk")
		STATES.SHELL_IDLE:
			idle()
			sprite.play("shell_idle")
		STATES.SHELL_HIT:
			pass


func set_state(new_state: STATES) -> void:
	if new_state == state:
		return
	
	state = new_state


func _ready() -> void:
	direction = -1.0


func idle() -> void:
	if !shell_mode:
		set_state(STATES.WALK)
	if shell_mode:
		set_state(STATES.SHELL_IDLE)
	
	velocity.x = 0


func walk() -> void:
	wall_bumped()
	
	if !shell_mode:
		velocity.x = direction * Speed
	if shell_mode:
		set_state(STATES.SHELL_IDLE)


func set_shell_mode(v: bool) -> void:
	shell_mode = v


func wall_bumped() -> void:
	if (is_on_wall() or ray_cast_wall.is_colliding()) or !ray_cast_floor.is_colliding(): 
		direction *= -1


func flip() -> void:
	if direction < 0:
		sprite.flip_h = false
		ray_cast_wall.target_position = Vector2(-20, 0)
		ray_cast_floor.position.x = -14
	else:
		sprite.flip_h = true
		ray_cast_wall.target_position = Vector2(20, 0)
		ray_cast_floor.position.x = 14


func _physics_process(_delta: float) -> void:
	handle_states()
	flip()
	
	move_and_slide()


func _on_area_test_body_entered(body: Node2D) -> void:
	if body is Player:
		is_player = true
		set_shell_mode(is_player)
		print("PLAYER ARGHHHHH")


func _on_area_test_body_exited(body: Node2D) -> void:
	if body is Player:
		is_player = false
		set_shell_mode(is_player)
		print("NO PLAYER")
