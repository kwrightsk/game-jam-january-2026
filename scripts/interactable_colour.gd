extends Area2D

var clickable = false
var colour

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	colour = get_child(1).animation


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(colour)\
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and Input.is_action_pressed("MOUSE_BUTTON_LEFT") and clickable:
		print(1)
	

func set_Colour():
	colour = get_child(1).animation
