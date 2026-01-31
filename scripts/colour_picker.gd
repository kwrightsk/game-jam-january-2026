extends Node

var colours = ["red", "blue", "green", "yellow"]
var matched = false
var selected_colour



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	selected_colour = $clickMe.get_Colour()
	print(selected_colour)
	rand_colours()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func rand_colours():
	var children = $clickables.get_children()
	# Assign random colours
	for c in children:
		c.set_Colour(colours[randi_range(0,3)])
	# Force one clickable to match
	var chosen = children.pick_random()
	chosen.set_Colour(selected_colour)
	#matched = true
	
