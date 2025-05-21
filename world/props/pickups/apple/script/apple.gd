extends PickupBase


func _physics_process(_delta: float) -> void:
	handle_collected(collected)


func _on_body_player_entered(body: Node2D) -> void:
	if body is Player:
		collected = true
		collected_sprite.play("default")
