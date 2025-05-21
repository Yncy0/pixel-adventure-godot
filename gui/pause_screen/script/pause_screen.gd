extends Control


@onready var starting_menu: PackedScene = preload("res://gui/starting_menu/scene/starting_menu.tscn")
#@onready var settings_menu: Control = $SettingsMenu
@onready var pause_panel: Panel = $Panel


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and pause_panel.visible == false:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		pause_panel.visible = true
		get_tree().paused = true
		print("ZA WARUDO")
	elif event.is_action_pressed("pause") and pause_panel.visible == true:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		pause_panel.visible = false
		get_tree().paused = false
	
	#if event.is_action("pause") and settings_menu.visible == true:
		#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		#pause_panel.visible = false
		#settings_menu.visible = false
		#get_tree().paused = false


func _on_settings_button_pressed() -> void:
	pause_panel.visible = false
	#settings_menu.visible = true



func _on_back_button_pressed() -> void:
	pause_panel.visible = false
	get_tree().paused = false
	print("Back")


func _on_exit_button_pressed() -> void:
	get_tree().paused = false
	get_tree().call_deferred("change_scene_to_packed", starting_menu)
	print("exit")
