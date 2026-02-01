extends Node

var colours = {
	"RED": Color.RED,
	"GREEN": Color.LIME_GREEN,
	"BLUE": Color.BLUE,
	"YELLOW": Color.YELLOW
}
var color_names = ["RED", "GREEN", "BLUE", "YELLOW"]
var matched = false
var selected_colour = ""

var redo = preload("res://Scenes/colour_picker.tscn")

@export var click_me_path: Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rand_name = color_names.pick_random()
	click_me_path.set_Colour(colours[rand_name])
	selected_colour = click_me_path.get_Colour()
	print(selected_colour)
	rand_colours()
	
	for c in $squares.get_children():
		print($sqaures.get_children())
		c.colourClicked.connect(_on_colour_clicked)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func rand_colours():
	var children = $squares.get_children()

	var shuffled_colours = color_names.duplicate()
	shuffled_colours.shuffle()

	var pool = []
	while pool.size() < children.size():
		pool += shuffled_colours
	
	pool.shuffle()

	for i in range(children.size()):
		children[i].set_Colour(colours[pool[i]]) # FIX HERE
		children[i].colour_name = pool[i]
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
