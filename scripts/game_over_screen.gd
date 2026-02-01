extends Node2D
@onready var hover_main_menu = $MainMenuButton/HoverMainMenu
@onready var hover_leaderboard = $LeaderBoardButton/HoverLeaderBoard
@onready var hover_play_again = $PlayAgainButton/HoverPlayAgain

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.round = 1
	hover_main_menu.visible = false
	hover_leaderboard.visible = false
	hover_play_again.visible = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_play_again_button_pressed() -> void:
	print("play again")
	get_tree().change_scene_to_file("res://Scenes/main_level.tscn") # Replace with function body.

func _on_leader_board_button_pressed() -> void:
	print("leader board")
	get_tree().change_scene_to_file("res://Scenes/leaderboard_screen.tscn")

func _on_main_menu_button_pressed() -> void:
	print("main menu")
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")

func _on_main_menu_button_mouse_entered() -> void:
	hover_main_menu.visible = true

func _on_main_menu_button_mouse_exited() -> void:
	hover_main_menu.visible = false

func _on_play_again_button_mouse_entered() -> void:
	hover_play_again.visible = true

func _on_play_again_button_mouse_exited() -> void:
	hover_play_again.visible = false

func _on_leader_board_button_mouse_entered() -> void:
	hover_leaderboard.visible = true

func _on_leader_board_button_mouse_exited() -> void:
	hover_leaderboard.visible = false
