extends CanvasLayer

@onready var level_complete_menu: Control = $"Level complete"
@onready var game_over_menu: Control = $"Game Over"
@onready var pause_menu: Control = $Pause
@onready var pause_button: TextureButton = $"UI/pause button"

var is_mobile: bool = false

func _ready() -> void:
	is_mobile = DisplayServer.is_touchscreen_available()
	if not is_mobile:
		$MobileButtons.hide()
	else:
		$MobileButtons.show()

# --- RESUME / PAUSE LOGIC ---
func _on_resume_button_pressed() -> void:
	pause_menu.hide()
	pause_button.show()
	get_tree().paused = false # Unfreeze game!
	if is_mobile:
		$MobileButtons.show()

func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scene/main_manu.tscn") # Replace with your exact main menu scene path
"""
func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	GameManager.reset_game()
"""
func _on_next_level_button_pressed() -> void:
	GameManager.load_next_level()
	
func _on_pause_button_pressed() -> void:
	pause_button.hide()
	pause_menu.show()
	get_tree().paused = true
	if is_mobile:
		$MobileButtons.hide()
