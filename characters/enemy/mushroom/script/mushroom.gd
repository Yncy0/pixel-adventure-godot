class_name Mushroom extends EnemyBase


@export var Bouncing_Power: float = -600.0


func _on_area_player_detect_body_entered(body: Node2D) -> void:
	if body is Player:
		body.velocity.y = Bouncing_Power
		sprite.play("hit")


func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "hit":
		sprite.play("idle")
