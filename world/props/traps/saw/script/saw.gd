extends AnimatedSprite2D


@export var Is_Moving: bool = false
@export var Timer_Time: float = 1.0
@export var Velocity: float = 50.0

@onready var timer: Timer = $Timer


var direction := -1.0


func _ready() -> void:
	if !Is_Moving:
		return
	else:
		timer.start(Timer_Time)


func _physics_process(delta: float) -> void:
	if !Is_Moving:
		return
	
	position.x += Velocity * direction * delta


func _on_hit_box_area_entered(area: Area2D) -> void:
	if area is HurtBox:
		print("BZZZZZZ")


func _on_timer_timeout() -> void:
	direction *= -1
	timer.start(Timer_Time)
