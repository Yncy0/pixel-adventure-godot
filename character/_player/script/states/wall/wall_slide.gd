class_name PlayerWallSlide extends PlayerState

func enter() -> void:
	player.sprite.play("wall")
	
	if player.direction:
		player.velocity.x 

func update_process(delta: float) -> void:
	player.wall_slide(delta)
	player.move()
	
	if Input.is_action_just_pressed("jump"):
		change_state.emit("PlayerJump")
		if player.is_on_wall() and player.wall_sliding:
			change_state.emit("PlayerWallJump")
	
	if !player.is_on_wall():
		change_state.emit("PlayerFall")
		# for safety purposes
		if player.is_on_floor():
			change_state.emit("PlayerIdle")
