extends CanvasLayer

@onready var rotate_prompt_panel: ColorRect = $RotatePromptPanel

func _ready() -> void:
	# Ensure this warning layer stays active even when the rest of the game is paused
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	# Connect to viewport resize events
	get_viewport().size_changed.connect(_check_orientation)
	
	# Initial check when game launches
	_check_orientation()

func _check_orientation() -> void:
	var viewport_size = get_viewport().get_visible_rect().size
	
	# If height > width, the phone is in Portrait mode
	if viewport_size.y > viewport_size.x:
		rotate_prompt_panel.show()
		get_tree().paused = true
	else:
		rotate_prompt_panel.hide()
		get_tree().paused = false
