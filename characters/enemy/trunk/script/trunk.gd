class_name Trunk extends EnemyBase


@export var Idle_Time: float = 1.0
@export var Wander_Time: float = 1.0

@onready var marker_shoot: Marker2D = %MarkerShoot
@onready var ray_cast: RayCast2D = $RayCast
@onready var ray_cast_wall: RayCast2D = $RayCastWall
@onready var ray_cast_floor: RayCast2D = $RayCastFloor
@onready var idle_timer: Timer = $IdleTimer
@onready var wander_timer: Timer = $WanderTimer

enum STATES {
	IDLE,
	RUN,
	SHOOT
}

var state: STATES = STATES.IDLE


func handle_states() -> void:
	match state:
		STATES.IDLE:
			idle()
			sprite.play("idle")

		STATES.RUN:
			run()
			sprite.play("run")
		STATES.SHOOT:
			shoot()
			sprite.play("shoot")


func set_state(new_state: STATES) -> void:
	if new_state == state:
		return
	
	state = new_state


func _ready() -> void:
	idle_timer.start(Idle_Time)


func idle() -> void:
	velocity.x = 0
	
	if is_player:
		set_state(STATES.SHOOT)

func run() -> void:
	if (is_on_wall() or ray_cast_wall.is_colliding()) or !ray_cast_floor.is_colliding():
		direction *= -1
	
	velocity.x = direction * Speed
	
	if is_player:
		set_state(STATES.SHOOT)


func shoot() -> void:
	idle_timer.stop()
	wander_timer.stop()
	velocity.x = 0
	
	if is_player:
		return
	if !is_player:
		print("bullshit")
		idle_timer.start(Idle_Time)
		set_state(STATES.IDLE)


func flip() -> void:
	if direction < 0:
		sprite.flip_h = false
		ray_cast.target_position = Vector2(-250, 0)
		ray_cast_wall.target_position = Vector2(-20, 0)
		ray_cast_floor.position.x = -10
		marker_shoot.position = Vector2(-12, 3)
	elif direction > 0:
		sprite.flip_h = true
		ray_cast.target_position = Vector2(250, 0)
		ray_cast_wall.target_position = Vector2(20, 0)
		ray_cast_floor.position.x = 10
		marker_shoot.position = Vector2(12, 3)


func _physics_process(_delta: float) -> void:
	handle_states()
	flip()
	
	if !ray_cast.is_colliding():
		is_player = false
	elif ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		if collider is not Player:
			is_player = false
		elif collider is Player:
			is_player = true
	
	move_and_slide()


func _on_idle_timer_timeout() -> void:
	idle_timer.stop()
	wander_timer.start(Wander_Time)
	direction = randf_range(-1, 1)
	set_state(STATES.RUN)


func _on_wander_timer_timeout() -> void:
	wander_timer.stop()
	idle_timer.start(Idle_Time)
	set_state(STATES.IDLE)
