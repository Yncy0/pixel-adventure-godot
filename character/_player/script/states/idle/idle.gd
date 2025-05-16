class_name PlayerIdle extends PlayerState

func enter() -> void:
	player.idle()
	
	player.is_jump_available = true
	
	if !player.direction and player.is_on_floor():
		player.sprite.play("idle")

func update_process(_delta: float) -> void:
	player.move()
	player.jump()
	
	if player.direction != 0:
		change_state.emit("PlayerMove")
	
	if !player.is_on_floor():
		change_state.emit("PlayerJump")
	
	if player.is_on_floor() and player.jump_buffered:
		player.jump()
