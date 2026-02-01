extends Node2D
@onready var button_sound = $BackButton/AudioStreamPlayer
@onready var hover_back_button = $BackButton/Panel2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hover_back_button.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_button_pressed() -> void:
	button_sound.play()
	await get_tree().create_timer(0.3).timeout
	load("res://Scenes/title_screen.tscn")
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")


func _on_back_button_mouse_entered() -> void:
	hover_back_button.visible = true


func _on_back_button_mouse_exited() -> void:
	hover_back_button.visible = false
