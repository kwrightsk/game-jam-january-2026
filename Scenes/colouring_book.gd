extends Node2D

func _ready() -> void:
	$MinigameTimer.start()

func _on_minigame_timer_timeout() -> void:
	print("you suck")
