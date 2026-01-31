extends Node2D

var brush_up = load("res://paintbrush-cursor.png")
var brush_down = load("res://paintbrush-cursor-down.png")

func _ready() -> void:
	Input.set_custom_mouse_cursor(brush_up)

func _process(delta: float) -> void:
	
	Input.set_custom_mouse_cursor(brush_up)
	
	if (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		Input.set_custom_mouse_cursor(brush_down)
