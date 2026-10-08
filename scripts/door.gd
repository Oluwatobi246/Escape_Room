extends Area2D

@onready var level_complete_menu: PanelContainer = $"../CanvasLayer/Level complete"
@onready var level_complete_sfx: AudioStreamPlayer2D = $"../CanvasLayer/Level complete/LevelCompleteSFX"
@onready var pause_button: TextureButton = $"../CanvasLayer/UI/pause button"
@onready var door: AnimatedSprite2D = $AnimatedSprite2D
@onready var mobile_button: Control = $"../CanvasLayer/MobileButtons"

func _on_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	# stil the same thing as .hide()
	mobile_button.visible = true
	
	# tells Godot to stop running any code inside this node
	mobile_button.process_mode = Node.PROCESS_MODE_DISABLED
	
	# tells Godot to ignore all touches/clicks on this node
	mobile_button.mouse_filter = Control.MOUSE_FILTER_IGNORE	

		
	body.hide()
	body.set_physics_process(false)
	door.play("default")
	level_complete_sfx.play()
		
	await get_tree().create_timer(1.2).timeout
	level_complete_menu.show()
	pause_button.hide()
	get_tree().paused = true
