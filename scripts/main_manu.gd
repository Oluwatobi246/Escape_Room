extends CanvasLayer

@onready var main_menu: PanelContainer = $"main menu"
@onready var instruction: PanelContainer = $instruction
@onready var level_panel: PanelContainer = $"level panel"

func _on_start_button_pressed() -> void:
	level_panel.show()

func _on_instructions_pressed() -> void:
	instruction.show()

func _on_back_button_pressed() -> void:
	level_panel.hide()
	instruction.hide()
	
func _on_level_1_pressed() -> void:
	GameManager.load_level(1)
	
func _on_level_2_pressed() -> void:
	if not $"level panel/levels/level 2".disabled:
		GameManager.load_level(2)

func _on_level_3_pressed() -> void:
	if not $"level panel/levels/level 3".disabled:
		GameManager.load_level(3)

func _on_level_4_pressed() -> void:
	if not $"level panel/levels/level 4".disabled:
		GameManager.load_level(4)

func _on_level_5_pressed() -> void:
	if not $"level panel/levels/level 5".disabled:
		GameManager.load_level(5)
