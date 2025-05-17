class_name PlayerWallJump extends PlayerState

func enter() -> void:
	player.wall_jump()
	player.sprite.play("jump")
	
	player.jump_available = 1

func update_process(_delta: float) -> void:
	player.wall_jump()
	
	if player.is_on_wall(): 
		change_state.emit("PlayerWallSlide")
	
	if !player.is_on_wall() and player.velocity.y > 0:
		change_state.emit("PlayerFall")
	if player.is_on_floor():
		change_state.emit("PlayerIdle")
