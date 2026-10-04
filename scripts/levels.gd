extends Control

@onready var level_1: TextureButton = $"level 1"
@onready var level_2: TextureButton = $"level 2"

func _ready() -> void:
	# Update buttons when opening Main Menu
	update_level(GameManager.max_unlocked_level)
	
	# Listen for unlock signals live
	if GameManager.has_signal("level_unlocked"):
		GameManager.level_unlocked.connect(update_level)

func update_level(num: int) -> void:
	# Level 1 is always playable
	level_1.disabled = false
	
	# Lock Level 2 ONLY if max unlocked level is less than 2
	level_2.disabled = (num < 2)
	
	$"level 3".disabled = num < 3
	
	$"level 4".disabled = num < 4
	$"level 5".disabled = num < 5
