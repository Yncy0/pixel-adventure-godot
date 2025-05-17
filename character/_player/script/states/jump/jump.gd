class_name PlayerJump extends PlayerState

func enter() -> void:
	player.jump()
	player.jump_available += 1
	
	if player.jump_available == 1:
		player.sprite.play("jump")
	elif player.jump_available == 2:
		player.sprite.play("double_jump")

func update_process(_delta: float) -> void:
	player.move()
	
	if player.velocity.y > 0:
		if player.jump_available <= player.MAX_JUMPS:
			change_state.emit("PlayerFall")
	
	if player.is_on_wall():
			change_state.emit("PlayerWallSlide")
