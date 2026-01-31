class_name Pixel
extends Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func change_color(color: String):
	match color:
		"red": $Area2D/PixelColor.color = Color.RED
		"blue": $Area2D/PixelColor.color = Color.BLUE
		"yellow": $Area2D/PixelColor.color = Color.YELLOW
		"green": $Area2D/PixelColor.color = Color.GREEN
	
func flash_on():
	$Area2D/Border.visible = true

func flash_off():
	$Area2D/Border.visible = false
	
