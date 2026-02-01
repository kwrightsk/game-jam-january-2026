extends Node
@onready var color_word = $CanvasLayer/ColorWord
@onready var word_background = $CanvasLayer/SquareColor1
var colours = {
	"red": Color.RED,
	"green": Color.LIME_GREEN,
	"blue": Color.BLUE,
	"yellow": Color.YELLOW
}
var color_names = ["red", "green", "blue", "yellow"]
var matched = false
var correct_color = ""
@export var round_path: NodePath
@onready var round = get_node(round_path)

func _ready() -> void:
	# Hide everything at start
	$CanvasLayer.visible = false
	
	for c in $CanvasLayer/squares.get_children():
		c.visible = false
		c.clickable = false
		
	# Connect signals
	for c in $CanvasLayer/squares.get_children():
		if not c.colourClicked.is_connected(_on_colour_clicked):
			c.colourClicked.connect(_on_colour_clicked)

func start_game() -> void:
	# Show CanvasLayer when game starts
	$CanvasLayer.visible = true
	
	matched = false
	correct_color = ""
	round.text = "Round "+ str(Globals.round)
	set_random_word()
	rand_colours()

func _process(delta: float) -> void:
	pass
	
func rand_colours():
	var children = $CanvasLayer/squares.get_children()
	var shuffled_colours = color_names.duplicate()
	shuffled_colours.shuffle()
	
	# Make sure the winning color is in the squares
	if not shuffled_colours.has(correct_color):
		shuffled_colours[0] = correct_color
		shuffled_colours.shuffle()
		
	var pool = []
	while pool.size() < children.size():
		pool += shuffled_colours
	
	pool.shuffle()
	for i in range(children.size()):
		children[i].visible = true
		children[i].set_Colour(pool[i])
		children[i].clickable = true

func _on_colour_clicked(colour):
	print("User clicked:", colour)
	print("Shape color was:", correct_color)
	
	if colour == correct_color:
		print("Correct!")
		Globals.round += 1
		get_parent().on_minigame_complete()
	else:
		print("Wrong!")
		get_parent().game_over()
		
func set_random_word():
	var word = color_names.pick_random()
	var font_colour = color_names.pick_random()
	var bg_colour = color_names.pick_random()

	# Optional: keep them all different
	while font_colour == word:
		font_colour = color_names.pick_random()

	while bg_colour == font_colour or bg_colour == word:
		bg_colour = color_names.pick_random()

	# Set word text
	color_word.text = word

	# Set font color
	color_word.add_theme_color_override(
		"font_color",
		colours[font_colour]
	)

	# Set background shape color
	word_background.color = colours[bg_colour]

	# THIS is the correct answer now
	correct_color = bg_colour

	print("Word:", word)
	print("Font color:", font_colour)
	print("Background color (correct):", bg_colour)

func hide_game():
	for c in $CanvasLayer/squares.get_children():
		c.clickable = false
		c.visible = false 
	$CanvasLayer.visible = false
