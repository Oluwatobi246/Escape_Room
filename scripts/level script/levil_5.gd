extends Node2D

@onready var trap_floor_1: AnimatableBody2D = $"trap floor 1"
@onready var trap_floor_1_s_p: Marker2D = $"trap floor 1 S_P"
@onready var trap_floor_1_x: float = $"trap floor 1".position.x

@onready var trap_floor_2: AnimatableBody2D = $"trap floor 2"

@onready var wall_move_1: AnimatableBody2D = $"wall move 1"
@onready var wall_move_1_s_p: Marker2D = $"wall move 1 S_P"

@onready var wall_move_2: AnimatableBody2D = $"wall move 2"
@onready var wall_move_2_s_p: Marker2D = $"wall move 2 S_P"


@onready var key: Node2D = $Key

func _ready() -> void:
	get_tree().paused = false
	trap_floor_2.hide()
	
	key.hide()

func _on_trap_floor_1_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"trap floor 1 trig/CollisionShape2D".set_deferred("disabled", true)
	var tween = create_tween()
	
	$"trap floor 1/AudioStreamPlayer2D".play()
	tween.tween_property(trap_floor_1, "global_position:x", 400, 0.5).as_relative()
	
	await get_tree().create_timer(1.0, false, true).timeout
	
	var rollback = create_tween()
	$"trap floor 1/AudioStreamPlayer2D".play()
	rollback.tween_property(trap_floor_1, "position:x", trap_floor_1_x, 0.5)
	
func _on_death_2_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
		
	if body.has_method("die"):
		body.die()

func _on_wall_move_1_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"wall move 1 trig/CollisionShape2D".set_deferred("disabled", true)
	
	var wall_1_tween = create_tween()
	$"wall move 1/AudioStreamPlayer2D".play()
	wall_1_tween.tween_property(wall_move_1, "global_position:y", wall_move_1_s_p.global_position.y, 0.1)
	
	var wall_2_tween = create_tween()
	$"wall move 2/AudioStreamPlayer2D".play()
	wall_2_tween.tween_property(wall_move_2, "global_position:y", wall_move_2_s_p.global_position.y, 0.1)
	
	
