extends Node2D

@onready var simon_says = $SimonSaysLevel
@onready var colour_picker = $ColourPicker
@onready var word_picker = $WordPicker
@onready var color_word_picker = $WordColorPicker
#@onready var score_label = $ScoreLabel
#@onready var game_over_label = $GameOverLabel

var mini_games = []
var current_game = null

func _ready():
	print("Children of main_level:")
	for child in get_children():
		print("  - ", child.name)
	mini_games = [simon_says, colour_picker, word_picker, color_word_picker]
	#game_over_label.visible = false
	#$Timer.start()
	#reset score
	#Globals.reset_score()
	#update_score()
	
	#start first random game
	load_random_minigame()

func _process(delta: float) -> void:
	if $UI/Timer.value == $UI/Timer.max_value:
		game_over()


func load_random_minigame():
	#hide all games first
	for game in mini_games:
		print("hiding", game)
		game.visible = false
		if game.has_method("hide_game"):
			game.hide_game()
	
	#pick random one (avoid repeating if possible)
	var next_game = mini_games.pick_random()
	while next_game == current_game and mini_games.size() > 1:
		next_game = mini_games.pick_random()
	
	print("selected game", next_game)
	#show and start it
	current_game = next_game
	current_game.visible = true
	if current_game.has_method("start_game"):
		print("starting", current_game)
		current_game.start_game()

func on_minigame_complete():
	#Globals.add_score(10)
	#update_score()
	$time.stop()
	$UI/Timer.value = 0
	print("success")
	await get_tree().create_timer(0.7).timeout
	load_random_minigame()
	if Globals.round % 5 == 0:
		$UI/Timer.max_value -= 1
	$time.start()
	

func game_over():
	#game_over_label.visible = true
	#game_over_label.text = "Game Over! Final Score: " + str(Globals.score)
	print("game over!")
	#hide current game
	if current_game:
		current_game.visible = false
		
	load("res://Scenes/game-over-screen.tscn")
	get_tree().change_scene_to_file("res://Scenes/game-over-screen.tscn")

#func update_score():
	#score_label.text = "Score: " + str(Globals.score)


func _on_time_timeout() -> void:
	$UI/Timer.value+=1
	#print(69)
