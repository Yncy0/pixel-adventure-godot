class_name PlayerFall extends PlayerState

func enter() -> void:
	player.sprite.play("fall")


func update_process(_delta: float) -> void:
	player.jump()
	player.move()
	
	if player.is_on_floor():
		change_state.emit("PlayerIdle")
