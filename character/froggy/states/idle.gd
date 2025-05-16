class_name PlayerIdle extends PlayerState

func enter() -> void:
	player.idle()
	
	if !player.direction and player.is_on_floor():
		player.sprite.play("idle")

func update_process(_delta: float) -> void:
	player.move()
	
	if player.direction != 0:
		change_state.emit("PlayerMove")
