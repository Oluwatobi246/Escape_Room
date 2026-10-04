extends Control

@onready var video_player: VideoStreamPlayer = $VideoStreamPlayer

var is_transitioning: bool = false

func _ready() -> void:
	# Trigger the delayed transition when video ends naturally
	video_player.finished.connect(_on_video_finished)
	
	await get_tree().process_frame
	video_player.play()

"""
func _input(event: InputEvent) -> void:
	# Tapping/pressing any key skips instantly
	if event.is_pressed() and not is_transitioning:
		_go_to_main_menu()
"""

func _on_video_finished() -> void:
	if is_transitioning:
		return
	is_transitioning = true
	
	# Pause on the final frame for 1.2 seconds before transitioning
	await get_tree().create_timer(1.2).timeout
	_go_to_main_menu()

func _go_to_main_menu() -> void:
	is_transitioning = true
	get_tree().change_scene_to_file("res://scene/main_manu.tscn")
