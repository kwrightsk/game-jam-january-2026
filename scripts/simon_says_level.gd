extends Node2D

@onready var PixelOne = $SimonSaysPixel
@onready var PixelTwo = $SimonSaysPixel2
@onready var PixelThree = $SimonSaysPixel3
@onready var PixelFour = $SimonSaysPixel4

var pattern = []
var numbers = [1, 2, 3, 4]
var last_number = null #to make sure a number doesn't repeat more than two times in a row 
var repeat_count = 0
var pattern_length = 3
var show_time := 0.5 #for the pixel pattern
var gap_time := 0.3 #for in between the pixels
var wait_time := 1 #for the user to read instructions

var can_input := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(PixelOne, PixelOne.get_class())
	PixelOne.change_color("red")
	PixelTwo.change_color("green")
	PixelThree.change_color("blue")
	PixelFour.change_color("yellow")
	
	#initialize pattern before the level starts :) 
	for i in range(pattern_length):
		pattern.append((pick_number())) 
	
	show_pattern_async()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_pattern_async() -> void:
	await show_pattern()
	
func show_pattern():
	can_input = false
	await get_tree().create_timer(wait_time).timeout
	
	for number in pattern:
		get_pixel(number).flash_on()
		await get_tree().create_timer(show_time).timeout
		get_pixel(number).flash_off()
		await get_tree().create_timer(gap_time).timeout
	
	can_input = true

func get_pixel(num: int):
	match num:
		1: return PixelOne
		2: return PixelTwo
		3: return PixelThree
		4: return PixelFour
	
#get the random number (but with my constraints)
func pick_number():
	var number = numbers.pick_random()
	
	if repeat_count == 2:
		var exclude_repeated_num = numbers.filter(func(n): return n != last_number)
		number = exclude_repeated_num.pick_random()
		repeat_count = 0
	elif last_number == number:
		repeat_count += 1
		last_number = number
	else:
		last_number = number
	return number

	
