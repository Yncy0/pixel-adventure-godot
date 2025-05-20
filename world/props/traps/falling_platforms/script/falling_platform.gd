extends CharacterBody2D


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer


var is_falling: bool = false


func _physics_process(delta: float) -> void:
	if is_falling:
		velocity.y += 980.0 / 2.0 * delta
		animated_sprite_2d.play("off")
		
	
	if is_on_floor():
		self.queue_free()
	
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		is_falling = true
		timer.start(3)


func _on_timer_timeout() -> void:
	timer.stop()
	self.queue_free()
