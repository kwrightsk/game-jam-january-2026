extends Node2D

@onready var PixelOne: ColorRect = $SimonSaysPixel/Area2D/PixelColor
@onready var PixelTwo: ColorRect = $SimonSaysPixel2/Area2D/PixelColor
@onready var PixelThree: ColorRect = $SimonSaysPixel3/Area2D/PixelColor
@onready var PixelFour: ColorRect = $SimonSaysPixel4/Area2D/PixelColor


var pattern = []
var numbers = [1, 2, 3, 4]
var last_number = null #to make sure a number doesn't repeat more than two times in a row 
var repeat_count = 0
var pattern_length = 6

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PixelOne.color = Color.RED
	PixelTwo.color = Color.GREEN
	PixelThree.color = Color.BLUE
	PixelFour.color = Color.YELLOW
	
	#initialize pattern before the level starts :) 
	for i in range(pattern_length):
		pattern.append((pick_number())) 
	print(pattern)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
#get the random number (but with my constraints)
func pick_number():
	var number = numbers.pick_random()
	
	if repeat_count >= 2:
		var exclude_repeated_num = numbers.filter(func(n): return n != last_number)
		number = exclude_repeated_num.pick_random()
	elif last_number == number:
		repeat_count += 1
		last_number = number
	else:
		last_number = number
	return number

	
