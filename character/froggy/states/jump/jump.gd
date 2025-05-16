class_name PlayerJump extends PlayerState

func enter() -> void:
	player.jump()
	player.sprite.play("jump")

func update_process(_delta: float) -> void:
	player.move()
	
	if player.is_on_floor():
		change_state.emit("PlayerIdle")
