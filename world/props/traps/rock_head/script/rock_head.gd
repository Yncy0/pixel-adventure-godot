extends CharacterBody2D


@export var Gravity := 980

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var ray_cast: RayCast2D = $RayCast
@onready var hit_box: HitBox = $HitBox
@onready var timer: Timer = $Timer


var original_position: Vector2
var time: float = 3
var stomp: bool = false
var is_blinking: bool = false


func _ready() -> void:
	original_position = position
	timer.start(time)


func _physics_process(delta: float) -> void:
	if !is_blinking:
		sprite.play("default")
	else:
		sprite.play("blink")
	
	if ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		if collider is Player:
			timer.stop()
			stomp = true
	else:
		if stomp and !is_on_floor():
			sprite.play("default")
			velocity.y += Gravity * delta
		
	if stomp and is_on_floor():
		sprite.play("hit_bottom")
		ray_cast.set_deferred("enabled", false)
		stomp = false
	
	if !stomp:
		velocity.y = -Gravity * delta
		sprite.play("default")
		timer.start(time)
	
	if is_on_ceiling():
		ray_cast.set_deferred("enabled", true)
	
	print("OG POS ", original_position.y)
	print("POS", position.y)
	
	move_and_slide()



func _on_hit_box_area_entered(area: Area2D) -> void:
	if area is HurtBox:
		print("SMASH!")


func _on_timer_timeout() -> void:
	print("Gonna Blink")
	is_blinking = true
	timer.stop()


func _on_sprite_animation_finished() -> void:
	if sprite.animation == "blink":
		print("Gonna stop Blinking")
		timer.start(time)
		is_blinking = false
	if sprite.animation == "hit_bottom":
		stomp = false
