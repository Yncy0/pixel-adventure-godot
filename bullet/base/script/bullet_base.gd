class_name BulletBase extends Area2D

@export var Bullet_Velocity: float = 100.0
@export var Timer_Time: float = 1.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer


var direction: float = -1.0


func shoot_x_axis(delta: float) -> void:
	timer.start(Timer_Time)
	position.x += Bullet_Velocity * direction * delta


func flip() -> void:
	if direction < 0:
		sprite.flip_h = false
	elif direction > 0:
		sprite.flip_h = true


func _on_timer_timeout() -> void:
	self.queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body:
		self.queue_free()
