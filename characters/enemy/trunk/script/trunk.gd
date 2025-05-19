class_name Trunk extends EnemyBase


@onready var bullets = preload("res://bullet/trunk/scene/trunk_bullet.tscn")
@onready var marker_shoot: Marker2D = %MarkerShoot
@onready var ray_cast: RayCast2D = $RayCast
@onready var ray_cast_wall: RayCast2D = $RayCastWall
@onready var ray_cast_floor: RayCast2D = $RayCastFloor
@onready var idle_timer: Timer = $IdleTimer
@onready var wander_timer: Timer = $WanderTimer


var idle_time: float = randf_range(1.0, 3.0)
var wander_time: float = randf_range(1.0, 3.0)
var has_shot: bool = false


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
	idle_timer.start(idle_time)


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
	
	if sprite.frame == 7 and !has_shot:
		bullet_instantiate()
		has_shot = true
	elif sprite.frame == 0:
		has_shot = false
	
	if is_player:
		return
	if !is_player:
		idle_timer.start(idle_time)
		set_state(STATES.IDLE)


func bullet_instantiate() -> void:
	var b = bullets.instantiate()
	b.direction = direction
	marker_shoot.add_child(b)


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
	wander_timer.start(wander_time)
	direction = randf_range(-1, 1)
	set_state(STATES.RUN)


func _on_wander_timer_timeout() -> void:
	wander_timer.stop()
	idle_timer.start(idle_time)
	set_state(STATES.IDLE)
