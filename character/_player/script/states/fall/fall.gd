class_name PlayerFall extends PlayerState

func enter() -> void:
	player.jump()
	player.sprite.play("fall")


func update_process(_delta: float) -> void:
	player.move()
	
	if Input.is_action_just_pressed("jump"):
		if player.jump_available < player.MAX_JUMPS:
			change_state.emit("PlayerJump")
		if player.is_on_wall():
			change_state.emit("PlayerWallJump")
	
	if player.is_on_floor():
		change_state.emit("PlayerIdle")
	
	if player.is_on_wall():
		player.sprite.play("wall")
