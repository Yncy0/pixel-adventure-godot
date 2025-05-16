class_name PlayerWallJump extends PlayerState

func enter() -> void:
	player.velocity.y = player.JUMP_VELOCITY
	player.sprite.play("double_jump")

func update_process(_delta: float) -> void:
	player.move()
	
	if player.is_on_wall() and player.velocity.y > 0:
		change_state.emit("PlayerFall")
	
	if !player.is_on_wall():
		change_state.emit("PlayerFall")
	
	# for safety purposes
	if player.is_on_floor():
		change_state.emit("PlayerIdle")
