class_name PlayerCamera extends Camera2D

@export var Camera_Limit_Left := -10000000
@export var Camera_Limit_Top  := -10000000
@export var Camera_Limit_Right  := 10000000
@export var Camera_Limit_Bottom  := 10000000

func _ready() -> void:
	limit_left = Camera_Limit_Left
	limit_top = Camera_Limit_Top
	limit_right = Camera_Limit_Right
	limit_bottom = Camera_Limit_Bottom
