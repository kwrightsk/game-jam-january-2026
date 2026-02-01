extends Node

var colours = {
	"red": Color.RED,
	"green": Color.LIME_GREEN,
	"blue": Color.BLUE,
	"yellow": Color.YELLOW
}
var color_names = ["red", "green", "blue", "yellow"]
var matched = false
var selected_colour = ""

var redo = preload("res://Scenes/colour_picker.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for c in $CanvasLayer/squares.get_children():
		var rand_name = color_names.pick_random()
		c.set_Colour(rand_name)
		selected_colour = c.get_Colour()
		print(selected_colour)
	rand_colours()
	for c in $CanvasLayer/squares.get_children():
		c.colourClicked.connect(_on_colour_clicked)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func rand_colours():
	var children = $CanvasLayer/squares.get_children()

	var shuffled_colours = color_names.duplicate()
	shuffled_colours.shuffle()

	var pool = []
	while pool.size() < children.size():
		pool += shuffled_colours
	
	pool.shuffle()

	for i in range(children.size()):
		children[i].set_Colour(pool[i])
		children[i].clickable = true

func _on_colour_clicked(colour):
	print("User clicked:", colour)
	if colour == selected_colour:
		print("Correct!")
		get_tree().reload_current_scene()
		
	else:
		print("Wrong!")
		
		
func set_random_word():
	var word = color_names.pick_random()
	var font_colour = color_names.pick_random()
	
	$ColorWord.text = word
	$ColorWord.add_theme_color_override(
		"font_color",
		colours[font_colour]
	)
	selected_colour = font_colour
