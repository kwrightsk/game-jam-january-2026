extends Node2D
@onready var hover_back = $CanvasLayer/BackButton/Panel2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hover_back.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_back_button_pressed() -> void:
	print("play again")
	get_tree().change_scene_to_file("res://Scenes/game-over-screen.tscn") # Replace with function body.
