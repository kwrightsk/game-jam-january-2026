extends Node2D

@onready var name_field = $UI/LineEdit
@onready var hover_play_button = $PlayButton/Panel2
@onready var button_sound = $PlayButton/AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hover_play_button.visible = false
	if(Globals.player_name == name_field.placeholder_text):
		name_field.text = ""
	else:
		name_field.text = Globals.player_name
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_play_button_pressed() -> void:
	print(button_sound)
	if (name_field.text == ""):
		Globals.set_player_name(name_field.placeholder_text)
	else:
		Globals.set_player_name(name_field.text)
	button_sound.play()
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_file("res://Scenes/main_level.tscn")

func _on_play_button_mouse_entered() -> void:
	hover_play_button.visible = true

func _on_play_button_mouse_exited() -> void:
	hover_play_button.visible = false

func _on_credits_button_pressed() -> void:
	load("res://Scenes/credits.tscn") 
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")
