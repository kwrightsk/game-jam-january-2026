extends Node2D

var levels_passed = 0 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func game_over():
	$GameOverLabel.visible = true
	await get_tree().create_timer(0.5).timeout
	$GameOverLabel.visible = false
	get_tree().change_scene_to_file("res://game-over-screen.tscn")
	
	
