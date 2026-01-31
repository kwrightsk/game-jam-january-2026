extends AnimatedSprite2D

class_name PaintbrushCursor

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
func _process(delta: float) -> void:
	var mouse_position = get_global_mouse_position()
	self.global_position = mouse_position
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		$paintbrush.play("click")
