extends Control


@onready var label: Label = %Label


func _process(_delta: float) -> void:
	label.text = "Score: " + str(PlayerStatus.score)
