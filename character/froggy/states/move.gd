class_name PlayerMove extends PlayerState

func enter() -> void:
	player.sprite.play("move")

func update_process(_delta: float) -> void:
	player.move()
	
	if player.direction == 0:
		change_state.emit("PlayerIdle")
