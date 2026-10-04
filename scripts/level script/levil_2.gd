extends Node2D

@onready var trap_1: Area2D = $"trap 1"
@onready var trap_2: Area2D = $"trap 2"
@onready var trap_3: Area2D = $"trap 3"
@onready var trap_4: Area2D = $"trap 4"
@onready var trap_5: Area2D = $"trap 5"
@onready var trap_6: Area2D = $"trap 6"
@onready var wall_move: AnimatableBody2D = $"wall move"
@onready var trap_1_t_a: Area2D = $"trap 1 T_A"
@onready var floor_1_trap: StaticBody2D = $"floor 1 trap"
@onready var trap_1_trig: Area2D = $"trap 1 trig"
@onready var floor_1_trap_trig_coll: CollisionShape2D = $"floor 1 trap trig/CollisionShape2D"
@onready var wall_move_coll: CollisionShape2D = $"wall move/CollisionShape2D"

var floor_1_start_x: float
var is_wall_active: bool = false
var trap_4_start_x: float
var trap_5_start_x: float

func _ready() -> void:
	get_tree().paused = false
	floor_1_start_x = floor_1_trap.position.x
	trap_4_start_x = trap_4.position.x
	trap_5_start_x = trap_5.position.x
	
	trap_1.hide()
	trap_1.monitoring = false
	
	# Use monitoring = false for Area2D nodes
	trap_1_trig.monitoring = false
	
	wall_move.hide()
	wall_move_coll.set_deferred("disabled", true)
	
	trap_2.monitoring = false
	trap_3.monitoring = false
	trap_4.monitoring = true
	trap_5.monitoring = true
	trap_6.monitoring = true

func _on_death_body_entered(body: Node2D) -> void:
	if body.name == "player" or body.is_in_group("player"):
		if body.has_method("die"):
			body.die()

# --- TRAP 1: Player steps on floor trigger ---
func _on_floor_1_trap_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
		
	floor_1_trap_trig_coll.set_deferred("disabled", true)
	
	$"floor sound".play()
	var tween = create_tween()
	tween.tween_property(floor_1_trap, "position:x", floor_1_start_x + 250.0, 0.7)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

	await get_tree().create_timer(2.0).timeout
	
	$"floor sound".play()
	var return_tween = create_tween()
	return_tween.tween_property(floor_1_trap, "position:x", floor_1_start_x, 0.9)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

# --- TRAP 2: Player steps on wall trigger ---
func _on_wall_move_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
		
	is_wall_active = true
	
	wall_move.show()
	wall_move_coll.set_deferred("disabled", false)
	$"wall move trig/CollisionShape2D".set_deferred("disabled", true)
	
	await get_tree().create_timer(0.1).timeout
	
	$"spike sound".play()
	# Slide the wall across both triggers
	var tween = create_tween()
	tween.tween_property(wall_move, "position:x", wall_move.position.x - 150.0, 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	tween.tween_interval(0.5)
	
	tween.tween_callback(wall_move.queue_free)

# --- TRAP 3: Wall hits Detector 1 (Floor trap pull) ---
func _on_area_2d_body_entered(body: Node2D) -> void:
	if not is_wall_active or body.name != "wall move":
		return
		
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	
	
	var tween = create_tween()
	tween.tween_property(floor_1_trap, "position:x", floor_1_start_x - 250.0, 0.9)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

	await get_tree().create_timer(2.0).timeout
	
	var return_tween = create_tween()
	return_tween.tween_property(floor_1_trap, "position:x", floor_1_start_x, 0.5)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

# --- TRAP 4: Wall hits Detector 2 (Activates trap_1_trig) ---
func _on_trap_1_t_a_body_entered(body: Node2D) -> void:
	if not is_wall_active or body.name != "wall move":
		return
	
	# Enable the player detector now that wall passed through
	trap_1_trig.monitoring = true
	

# --- TRAP 5: Player steps on activated trap_1_trig ---
func _on_trap_1_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return

	$"spike sound".play()
	trap_1.show()
	trap_1.monitoring = true

func _on_trap_4_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	trap_4.monitoring = true
	$"trap 4 trig/CollisionShape2D".set_deferred("disabled", true)
	
	$"spike sound".play()
	var tween = create_tween()
	tween.tween_property(trap_4, "position:x", trap_4_start_x + 50.0, 0.3)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	await get_tree().create_timer(0.9).timeout
	
	$"spike sound".play()
	var return_tween = create_tween()
	return_tween.tween_property(trap_4, "position:x", trap_4_start_x, 0.3)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
func _on_trap_5_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	trap_5.monitoring = true
	$"trap 5 trig/CollisionShape2D".set_deferred("disabled", true)
	
	$"spike sound".play()
	var tween = create_tween()
	tween.tween_property(trap_5, "position:x", trap_5_start_x + 50.0, 0.3)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	await get_tree().create_timer(0.9).timeout
	
	$"spike sound".play()
	var return_tween = create_tween()
	return_tween.tween_property(trap_5, "position:x", trap_5_start_x, 0.3)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
