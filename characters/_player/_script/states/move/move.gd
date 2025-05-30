class_name PlayerMove extends PlayerState

func enter() -> void:
	player.sprite.play("move")

func update_process(_delta: float) -> void:
	player.move()
	player.jump()
	
	if player.direction == 0:
		change_state.emit("PlayerIdle")
	
	if !player.is_on_floor():
		change_state.emit("PlayerJump")
	
	if player.is_on_floor() and player.jump_buffered:
		print("I AM BUFFERING")
		player.jump()
