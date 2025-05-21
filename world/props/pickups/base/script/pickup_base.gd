class_name PickupBase extends Area2D


@onready var sprite: AnimatedSprite2D = $Sprite
@onready var collected_sprite: AnimatedSprite2D = $CollectedSprite
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


var collected: bool = false
var removed: bool = false


func handle_collected(is_collected: bool) -> void:
	if is_collected:
		collected_sprite.set_deferred("visible", true)
		sprite.set_deferred("visible", false)
		collision_shape_2d.set_deferred("disabled", true)
	
	if removed:
		self.queue_free()

func _on_collected_sprite_animation_finished() -> void:
	if sprite.animation == "default":
		removed = true
