extends Node
@onready var color_word = $CanvasLayer/ColorWord
var colours = {
	"red": Color.RED,
	"green": Color.LIME_GREEN,
	"blue": Color.BLUE,
	"yellow": Color.YELLOW
}
var color_names = ["red", "green", "blue", "yellow"]
var matched = false
var selected_colour = ""
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
	selected_colour = ""
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
	if not shuffled_colours.has(selected_colour):
		shuffled_colours[0] = selected_colour
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
	print("Font color was:", selected_colour)
	
	if colour == selected_colour:
		print("Correct!")
		Globals.round += 1
		get_parent().on_minigame_complete()
	else:
		print("Wrong!")
		get_parent().game_over()
		
func set_random_word():
	var word = color_names.pick_random()
	var font_colour = color_names.pick_random()
	
	# Make sure they are not the same colour
	while font_colour == word:
		font_colour = color_names.pick_random()
		
	color_word.text = word
	color_word.add_theme_color_override(
		"font_color",
		colours[font_colour]
	)
	selected_colour = font_colour
	print("Word says: ", word, " but is colored: ", font_colour)

func hide_game():
	for c in $CanvasLayer/squares.get_children():
		c.clickable = false
		c.visible = false 
	$CanvasLayer.visible = false
