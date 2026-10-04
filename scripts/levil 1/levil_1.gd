extends Node2D

@onready var pause_button: TextureButton = $"CanvasLayer/UI/pause button"
@onready var level_complete_sfx: AudioStreamPlayer2D = $"CanvasLayer/Level complete/LevelCompleteSFX"

# --- TRAP 1 & WALL 1 ---
@onready var trap_1: Area2D = $"trap 1"
@onready var t_t_1: Area2D = $"t_t 1"
@onready var trap_wall_1: AnimatableBody2D = $"trap wall 1"
@onready var wall_trigger: Area2D = $"trap wall trigger"
@onready var trap_wall_1_shape: CollisionShape2D = $"trap wall 1/CollisionShape2D"

# --- TRAP FLOOR & DEATH TRIGGER ---
@onready var trap_floor: AnimatableBody2D = $"trap floor"
@onready var trap_floor_trigger: Area2D = $"trap floor trigger"
@onready var death_trigger: Area2D = $"death trigger"
@onready var trap_floor_trig_coll: CollisionShape2D = $"trap floor trigger/CollisionShape2D"

# --- TRAP WALL 2 ---
@onready var trap_wall_2: AnimatableBody2D = $"trap wall 2"
@onready var trap_wall_2_coll: CollisionShape2D = $"trap wall 2/CollisionShape2D"
@onready var trap_wall_2_trig: Area2D = $"trap wall 2 trigger"

# --- TRAP 2 (SPIKE 2) ---
@onready var trap_2: Area2D = $"trap 2"
@onready var trap_2_trigger: Area2D = $"trap 2 trigger"

@onready var door: AnimatedSprite2D = $"door/AnimatedSprite2D"
@onready var level_complete_menu: Control = $"CanvasLayer/Level complete"
@onready var game_over_menu: Control = $"CanvasLayer/Game Over"
@onready var pause_menu: Control = $"CanvasLayer/Pause"


func _ready() -> void:
	get_tree().paused = false
	# Hide trap 1
	trap_1.hide()
	trap_1.monitoring = false
	
	# Hide wall 1
	trap_wall_1.hide()
	trap_wall_1_shape.set_deferred("disabled", true)
	
	# Hide wall 2
	trap_wall_2.hide()
	trap_wall_2_coll.set_deferred("disabled", true)
	
	# Hide trap 2
	trap_2.hide()
	trap_2.monitoring = false
	
	get_tree().paused = false

# --- TRAP 1 FUNCTIONS ---
func _on_t_t_1_body_entered(body: Node2D) -> void:
	if body.name == "player" or body.is_in_group("player"):
		$"spike sound".play()
		trap_1.show()
		trap_1.monitoring = true
		t_t_1.queue_free()

func _on_trap_wall_trigger_body_entered(body: Node2D) -> void:
	if body.name == "player" or body.is_in_group("player"):
		trap_wall_1.show()
		trap_wall_1_shape.set_deferred("disabled", false)
		
		$"move wall sound".play()
		
		var tween = create_tween()
		tween.tween_property(trap_wall_1, "position:x", trap_wall_1.position.x - 180, 0.2)\
			.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			
		tween.tween_callback(func():
			trap_wall_1.queue_free()
		)
		
		wall_trigger.queue_free()

# --- TRAP FLOOR FUNCTIONS ---
func _on_trap_floor_trigger_body_entered(body: Node2D) -> void:
	if body.name == "player" or body.is_in_group("player"):
		trap_floor_trig_coll.set_deferred("disabled", true)
		$"trap floor/CollisionShape2D".set_deferred("disabled", true)
		
		$"move floor sound".play()
		var tween = create_tween()
		tween.tween_property(trap_floor, "position:x", trap_floor.position.x + 250, 0.008)\
			.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		
		await get_tree().create_timer(2.0).timeout
		
		$"move floor return sound".play()
		$"trap floor/CollisionShape2D".set_deferred("disabled", false)
		var return_tween = create_tween()
		return_tween.tween_property(trap_floor, "position:x", trap_floor.position.x - 250, 0.4)\
			.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)

func _on_death_trigger_body_entered(body: Node2D) -> void:
	if body.name == "player" or body.is_in_group("player"):
		if body.has_method("die"):
			body.die()

# --- TRAP WALL 2 FUNCTIONS ---
func _on_trap_wall_2_trigger_body_entered(body: Node2D) -> void:
	if body.name == "player" or body.is_in_group("player"):
		
		trap_wall_2.show()
		trap_wall_2_coll.set_deferred("disabled", false)
		
		# Reactivate trap floor trigger!
		trap_floor_trig_coll.set_deferred("disabled", false)
		
		$"move wall sound".play()
		var tween = create_tween()
		tween.tween_property(trap_wall_2, "position:x", trap_wall_2.position.x - 200, 0.25)\
			.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			
		tween.tween_callback(func():
			trap_wall_2.queue_free()
		)
		
		trap_wall_2_trig.queue_free()

# --- TRAP 2 FUNCTIONS ---
func _on_trap_2_trigger_body_entered(body: Node2D) -> void:
	if body.name == "player" or body.is_in_group("player"):
		$"spike sound".play()
		trap_2.show()
		trap_2.monitoring = true
		trap_2_trigger.queue_free()

func _on_door_body_entered(body: Node2D) -> void:
	if body.name == "player" or body.is_in_group("player"):
		body.hide()
		body.set_physics_process(false)
		door.play("default")
		level_complete_sfx.play()
		
		await get_tree().create_timer(1.2).timeout
		level_complete_menu.show()
		pause_button.hide()
		get_tree().paused = true
	
