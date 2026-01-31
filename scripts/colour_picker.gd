extends Node

var colours = ["red", "blue", "green", "yellow"]
var matched = false
var selected_colour

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
	# Assign random colours
	for c in children:
		c.set_Colour(colours[randi_range(0,3)])
		c.clickable = true
	
	# Force one clickable to match
	var chosen = children.pick_random()
	chosen.set_Colour(selected_colour)
	#matched = true
	

func _on_colour_clicked(colour):
	print("User clicked:", colour)
	if colour == selected_colour:
		print("Correct!")
	else:
		print("Wrong!")
