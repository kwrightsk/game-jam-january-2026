extends Node2D
@onready var PixelOne = $SimonSaysPixel
@onready var PixelTwo = $SimonSaysPixel2
@onready var PixelThree = $SimonSaysPixel3
@onready var PixelFour = $SimonSaysPixel4
@export var round_path: NodePath
@onready var round = get_node(round_path)
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

func _ready() -> void:
	# Setup pixels colors and numbers (only once)
	PixelOne.change_color("red")
	PixelOne.assign_number(1)
	PixelTwo.change_color("green")
	PixelTwo.assign_number(2)
	PixelThree.change_color("blue")
	PixelThree.assign_number(3)
	PixelFour.change_color("yellow")
	PixelFour.assign_number(4)
	
	# Connect input events (only once)
	for pixel in [PixelOne, PixelTwo, PixelThree, PixelFour]:
		var area = pixel.get_node("Area2D")
		if not area.input_event.is_connected(_on_pixel_clicked):
			area.input_event.connect(_on_pixel_clicked.bind(pixel))

func start_game() -> void:
	self.visible = true 
	
	#reset game state
	pattern = []
	pattern_pos = 0
	can_input = false
	
	#difficulty set up - increase every 6 rounds starting from round 3
	# Round 3: length 4, Round 6: length 5, Round 9: length 6, etc.
	pattern_length = 3 + int((Globals.round - 1) / 3)
	if pattern_length > 10:
		pattern_length = 10
		
	#generate new pattern
	for i in range(pattern_length):
		pattern.append(pick_number())
	print("Generated pattern: ", pattern, " (length: ", pattern.size(), ")")
	round.text = "Round "+ str(Globals.round)
	
	#show the pattern 
	await show_pattern()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_pixel_clicked(viewport, event, shape_idx, pixel: Pixel):
	if can_input and event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("=== CLICK DETECTED on: ", pixel.name, " number: ", pixel.number, " ===")
		
		# Disable input immediately to prevent double-clicks
		can_input = false
		
		pixel.flash_on()
		await get_tree().create_timer(0.2).timeout
		pixel.flash_off()
		check_player_input(pixel)
		
		# Re-enable input after checking (if not game over)
		if pattern_pos < pattern.size():
			can_input = true
			get_parent().start_timer()
			

func check_player_input(pixel: Pixel):
	print("Clicked: ", pixel.number, " | Expected: ", pattern[pattern_pos], " | Position: ", pattern_pos)
	
	if pixel.number != pattern[pattern_pos]:
		print("WRONG! Game Over")
		get_parent().game_over()
	else:
		print("CORRECT!")
		pattern_pos += 1
		if pattern_pos >= pattern.size():
			print("Success! Full pattern clicked!")
			Globals.round += 1
			print("Incremented Globals.round to: ", Globals.round)
			get_parent().on_minigame_complete()
	
func show_pattern():
	can_input = false
	await get_tree().create_timer(wait_time).timeout
	
	for number in pattern:
		get_pixel(number).flash_on()
		await get_tree().create_timer(show_time).timeout
		get_pixel(number).flash_off()
		await get_tree().create_timer(gap_time).timeout
	
	can_input = true
	get_parent().start_timer()

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
	else:
		repeat_count = 0
		
	last_number = number
	return number
