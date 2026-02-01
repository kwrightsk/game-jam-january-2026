extends Node2D

var paint = preload("res://Scenes/paint.tscn")
var bug = preload("res://Scenes/colour_eater_bug.tscn")

func _ready() -> void:
	pass
	#$MinigameTimer.start()
	#$BugSpawnTimer.start()
	
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("MOUSE_BUTTON_LEFT"):
		var paint_instance = paint.instantiate()
		paint_instance.position = get_global_mouse_position()
		add_child(paint_instance)
		print("hi")

func _on_minigame_timer_timeout() -> void:
	print("you suck")


func _on_bug_spawn_timer_timeout() -> void:
	pass
	print("bug")
	var bug_instance = bug.instantiate()
	bug_instance.position = Vector2(randf_range(10, 300), randf_range(100, 500))
	#bug_instance.rotatation_degrees = randf_range(-180, 180)
	add_child(bug_instance)


func _on_paint_child_entered_tree(node: Node) -> void:
	pass
