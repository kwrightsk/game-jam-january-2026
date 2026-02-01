class_name Pixel
extends Node2D

var number = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func assign_number(num: int):
	number = num
	
func change_color(color: String):
	match color:
		"red": $Area2D/PixelColor.color = Color(237/255.0, 28/255.0, 37/255.0, 1.0)
		"blue": $Area2D/PixelColor.color = Color(63/255.0, 72/255.0, 204/255.0, 1.0)
		"yellow": $Area2D/PixelColor.color = Color(255/255.0, 242/255.0, 4/255.0, 1.0)
		"green": $Area2D/PixelColor.color = Color(34/255.0, 177/255.0, 76/255.0, 1.0)
	
func flash_on():
	$Area2D/Border.visible = true

func flash_off():
	$Area2D/Border.visible = false
	
