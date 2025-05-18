class_name Chicken extends EnemyBase


func _physics_process(delta: float) -> void:
	if !is_player:
		velocity.x = move_toward(velocity.x, 0.0, Speed)
	if is_player:
		var dir = (_Player.global_position - global_position).normalized()
		velocity.x = dir.x * Speed
	
	move_and_slide()


func _on_area_player_detect_body_entered(body: Node2D) -> void:
	if body is Player:
		is_player = true



func _on_area_player_detect_body_exited(body: Node2D) -> void:
	if body is Player:
		is_player = false
