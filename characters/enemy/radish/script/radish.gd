class_name Radish extends EnemyBase


@export var Has_Leaf: bool = true

@onready var ray_cast_wall: RayCast2D = $RayCastWall
@onready var ray_cast_floor: RayCast2D = $RayCastFloor


var hit_counter: int = 0


enum STATES {
	IDLE,
	IDLE_2,
	HIT,
	RUN,
}

var state: STATES = STATES.IDLE


func handle_states() -> void:
	match state:
		STATES.IDLE:
			idle()
		STATES.RUN:
			run()
		STATES.HIT:
			pass


func set_state(s: STATES) -> void:
	if s == state:
		return
	
	state = s


func _ready() -> void:
	if Has_Leaf:
		set_state(STATES.IDLE)
	elif !Has_Leaf:
		set_state(STATES.RUN)
		hit_counter += 1


func idle() -> void:
	ray_detect()
	sprite.play("idle")
	velocity.x = direction * Speed


func run() -> void:
	ray_detect()
	#sprite.play("run")
	#velocity.x = direction * Speed
	sprite.play("idle_2")
	velocity.x = 0


func hit() -> void:
	pass


func flip() -> void:
	if direction < 0:
		sprite.flip_h = false
		ray_cast_wall.rotation_degrees = 0
		ray_cast_floor.position.x = -14
	if direction > 0:
		sprite.flip_h = true
		ray_cast_floor.position.x = 14
		ray_cast_wall.rotation_degrees = 270


func ray_detect() -> void:
	if (ray_cast_wall.is_colliding()):
		direction *= -1


func _physics_process(delta: float) -> void:
	handle_states()
	flip()
	
	#if !Has_Leaf and !is_on_floor():
		#velocity.y += 980 * delta
	
	move_and_slide()
