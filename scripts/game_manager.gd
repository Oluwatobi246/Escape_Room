extends Node2D

"signal game_over_triggered" # remove this
signal level_unlocked

"var max_hearts: int = 4
var current_hearts: int = 4"

var current_level: int = 1
var max_unlocked_level: int = 1
var save_path: String = "user://save_game.cfg" #remove this

func _ready() -> void:
	#load_progress() remove this
	pass

"""
func save_progress() -> void:
	var config = ConfigFile.new()
	config.set_value("Progress", "max_unlocked_level", max_unlocked_level)
	config.save(save_path)
	
func load_progress() -> void:
	var config = ConfigFile.new()
	var error = config.load(save_path)
	
	if error == OK:
		max_unlocked_level = config.get_value("Progress", "max_unlocked_level", 1)
""" #remove this
	
func load_level(level_num:int) -> void:
	if level_num <= max_unlocked_level:
		current_level = level_num
		
		"current_hearts = max_hearts"
		
		get_tree().paused = false
		get_tree().change_scene_to_file("res://scene/levels/levil_" + str(current_level) + ".tscn")

func load_next_level() -> void:
	# Only raise next level if we just beat out current max level
	if current_level == max_unlocked_level:
		max_unlocked_level += 1
		# save_progress() remvoe this
		level_unlocked.emit()
		
	current_level += 1
	
	"current_hearts = max_hearts"
	
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scene/levels/levil_" + str(current_level) + ".tscn")

	
"func lose_heart() -> void:
	current_hearts -= 1
	
	if current_hearts == 0:
		get_tree().paused = true
		game_over_triggered.emit()
	else:
		get_tree().reload_current_scene()

func reset_game() -> void:
	current_hearts = max_hearts
	get_tree().paused = false
	get_tree().reload_current_scene()"
