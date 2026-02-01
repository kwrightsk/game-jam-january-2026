extends "res://scripts/main_level.gd"

@onready var PixelOne = $SimonSaysPixel
@onready var PixelTwo = $SimonSaysPixel2
@onready var PixelThree = $SimonSaysPixel3
@onready var PixelFour = $SimonSaysPixel4

var pattern = []
var numbers = [1, 2, 3, 4]
var last_number = null #to make sure a number doesn't repeat more than two times in a row 
var repeat_count = 0
var pattern_length = 3
var pattern_pos = 0
var show_time := 0.5 #for the pixel pattern
var gap_time := 0.3 #for in between the pixels
var wait_time := 1 #for the user to read instructions

var can_input := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PixelOne.change_color("red")
	PixelOne.assign_number(1)
	PixelTwo.change_color("green")
	PixelTwo.assign_number(2)
	PixelThree.change_color("blue")
	PixelThree.assign_number(3)
	PixelFour.change_color("yellow")
	PixelFour.assign_number(4)
	
	for pixel in [PixelOne, PixelTwo, PixelThree, PixelFour]:
		var area = pixel.get_node("Area2D")
		area.input_event.connect(_on_pixel_clicked.bind(pixel))
	#initialize pattern before the level starts :) 
	for i in range(pattern_length):
		pattern.append((pick_number())) 
	
	await show_pattern()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_pixel_clicked(viewport, event, shape_idx, pixel: Pixel):
	if can_input and event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		pixel.flash_on()
		await get_tree().create_timer(0.2).timeout
		pixel.flash_off()
		check_player_input(pixel)

func check_player_input(pixel: Pixel):
	if pixel.number != pattern[pattern_pos]:
		game_over()
		#game_over()#will trigger game over
	else:
		pattern_pos += 1
		if pattern_pos >= pattern.size():
			print("Success! Full pattern clicked!")
	
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
