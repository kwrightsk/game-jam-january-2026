extends Node2D

@onready var simon_says = $SimonSaysLevel
@onready var colour_picker = $ColourPicker
@onready var word_picker = $WordPicker
@onready var color_word_picker = $WordColorPicker
@onready var shape_color_picker = $ShapeColorPicker
#@onready var score_label = $ScoreLabel
#@onready var game_over_label = $GameOverLabel

var path = "user://game-stats.json"
var mini_games = []
var current_game = null

func _ready():
	print("Children of main_level:")
	for child in get_children():
		print("  - ", child.name)
	mini_games = [simon_says, colour_picker, word_picker, color_word_picker, shape_color_picker]
	#game_over_label.visible = false
	#$Timer.start()
	#reset score
	#Globals.reset_score()
	#update_score()
	
	#start first random game
	load_random_minigame()
	for game in [
		simon_says,
		colour_picker,
		word_picker,
		color_word_picker,
		shape_color_picker
	]:
		print(game)

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
	save_to_file()
	save_to_leaderboard()
	load("res://Scenes/game-over-screen.tscn")
	get_tree().change_scene_to_file("res://Scenes/game-over-screen.tscn")

#func update_score():
	#score_label.text = "Score: " + str(Globals.score)



func _on_time_timeout() -> void:
	$UI/Timer.value+=1
	#print(69)

func save_to_file():
	
	#Saves current game stats and checks if we beat our prev score. If we did it updates our best game stats.
	#File is saved in user folder. To find it follow Project->Open user data folder

	var current_game_stats = {
		"Score" : Globals.round,
	} 
	
	var game_stats = {
		"Last Game" : current_game_stats,
		"Best Game" : current_game_stats
	}
	
	var file = FileAccess.open(path, FileAccess.READ)
	#if file exists and has data in it, read existing stats and store them in game_stats
	print(game_stats.size())
	if file != null and file.get_as_text() != "":
		game_stats = JSON.parse_string(file.get_as_text())
		if game_stats["Best Game"]["Score"] < current_game_stats["Score"]:
			game_stats["Best Game"] = current_game_stats
			game_stats["Last Game"] = current_game_stats

	#We open the file in WRITE mode (we will overwrite)
	file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(JSON.stringify(game_stats))
	file.close()
	
func save_to_leaderboard():
	var leaderboard_path := "user://leaderboard.json"
	
	var final_score = Globals.round
	var player_info= {
		"Name" : Globals.player_name,
		"Score" : final_score,
	} 
	
	var leaderboard = []
	var file = FileAccess.open(leaderboard_path, FileAccess.READ)

	#if file exists and has data in it, read existing leaderboard
	if file != null:
		if file.get_as_text() != "":
			leaderboard = JSON.parse_string(file.get_as_text())
	
	leaderboard.append(player_info)
	#sort the leaderboard by score
	leaderboard.sort_custom(_compare_scores)
	
	# Only store the top 10 names to save on memory!
	if leaderboard.size() > 10:
		leaderboard.remove_at(10) # remove the 11th item
	
	print("\nLEADERBOARD\n",leaderboard)
	print("Leaderboard size: " + str(leaderboard.size()))
	
	file = FileAccess.open(leaderboard_path, FileAccess.WRITE)
	file.store_string(JSON.stringify(leaderboard))
	file.close()

#helper function to compare scores (tbt to cmpt280 <3)
func _compare_scores(player1, player2):
	return player1["Score"] > player2["Score"]
