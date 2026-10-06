extends CanvasLayer

@onready var rotate_prompt_panel: ColorRect = $RotatePromptPanel

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_viewport().size_changed.connect(_check_orientation)
	_check_orientation()

func _check_orientation() -> void:
	# Get the real physical screen/browser window dimensions
	var window_size = DisplayServer.window_get_size()
	
	# If height > width, the phone is physically in Portrait mode
	if window_size.y > window_size.x:
		rotate_prompt_panel.show()
		get_tree().paused = true
	else:
		# Only unpause if the warning panel was active
		if rotate_prompt_panel.visible:
			rotate_prompt_panel.hide()
			get_tree().paused = false
