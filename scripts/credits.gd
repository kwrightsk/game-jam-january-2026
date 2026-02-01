extends Node2D
@onready var button_sound = $BackButton/AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_button_pressed() -> void:
	button_sound.play()
	await get_tree().create_timer(0.3).timeout
	load("res://Scenes/title_screen.tscn")
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
