class_name Chicken extends EnemyBase


@onready var ray: RayCast2D = $RayCastPlayerDetect

enum STATES {
	IDLE,
	CHASE,
}
var state: STATES = STATES.IDLE


func handle_state():
	match state:
		STATES.IDLE:
			sprite.play("idle")
			idle()
			
		STATES.CHASE:
			sprite.play("run")
			chase()


func set_state(new_state: STATES) -> void:
	if new_state == state:
		return
	
	state = new_state


func idle():
	velocity.x = move_toward(velocity.x, 0.0, Speed)
	
	if is_player:
		set_state(STATES.CHASE)


func chase():
	if !is_player:
		set_state(STATES.IDLE)
	
	var dir = (_Player.global_position - global_position).normalized()
	velocity.x = dir.x * Speed


func spot_enemy():
	if ray.is_colliding():
		var collider = ray.get_collider()
		if collider is not Player:
			is_player = false
			set_state(STATES.IDLE)
		else:
			is_player = true
			set_state(STATES.CHASE)


func enemy_flip():
	if velocity.x > 0:
		ray.rotation_degrees = 0
		sprite.flip_h = true
	elif velocity.x < 0:
		ray.rotation_degrees = 180
		sprite.flip_h = false


func _physics_process(delta: float) -> void:
	handle_gravity(delta)
	handle_state()
	spot_enemy()
	enemy_flip()
	
	move_and_slide()


func _on_area_player_detect_body_entered(body: Node2D) -> void:
	if body is Player:
		is_player = true


func _on_area_player_detect_body_exited(body: Node2D) -> void:
	if body is Player:
		is_player = false
