class_name TrunkBullet extends BulletBase


func _physics_process(delta: float) -> void:
	sprite.play("default")
	flip()
	shoot_x_axis(delta)
