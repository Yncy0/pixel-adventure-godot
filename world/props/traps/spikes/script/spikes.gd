extends AnimatedSprite2D


func _on_hit_box_area_entered(area: Area2D) -> void:
	if area is HurtBox:
		print("KYAHs")
