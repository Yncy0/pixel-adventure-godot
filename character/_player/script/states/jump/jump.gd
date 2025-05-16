class_name PlayerJump extends PlayerState

func enter() -> void:
	player.jump()
	player.is_jump_available = false
	player.sprite.play("jump")

func update_process(_delta: float) -> void:
	player.move()
	
	if player.velocity.y > 0:
		change_state.emit("PlayerFall")
