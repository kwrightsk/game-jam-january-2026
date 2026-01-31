extends Node

var colours = ["red", "blue", "green", "yellow"]
var matched = false
var selected_colour

var redo = preload("res://Scenes/colour_picker.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$clickMe.set_Colour((colours[randi_range(0,3)]))
	
	selected_colour = $clickMe.get_Colour()
	# print(selected_colour)
	rand_colours()
	
	for c in $clickables.get_children():
		c.colourClicked.connect(_on_colour_clicked)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func rand_colours():
	var children = $clickables.get_children()

	# Make a shuffled copy of the colours
	var shuffled_colours = colours.duplicate()
	shuffled_colours.shuffle()

	# Assign one colour per clickable
	for i in children.size():
		children[i].set_Colour(shuffled_colours[i])
		children[i].clickable = true

	

func _on_colour_clicked(colour):
	print("User clicked:", colour)
	if colour == selected_colour:
		print("Correct!")
		get_tree().reload_current_scene()
		
	else:
		print("Wrong!")
