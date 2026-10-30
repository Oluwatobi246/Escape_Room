extends Node2D

@onready var push_up: AnimatableBody2D = $"floor 3/push up"
@onready var player: CharacterBody2D = $player
@onready var floor_3: AnimatableBody2D = $"floor 3"

var is_bouncing: bool = false
var launch_force: float = -650.0

func _ready() -> void:
	pass
"""
func bounce_up(block: AnimatableBody2D) -> void:
	if is_bouncing:
		return
 
	is_bouncing = true
	

	var start_pos: Vector2 = block.position
	var up_pos: Vector2 = start_pos + Vector2(0, -40)
	
	var bounce_tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	
	bounce_tween.tween_property(block, "position", up_pos, 0.08)\
		.set_trans(Tween.TRANS_QUAD)\
		.set_ease(Tween.EASE_OUT)
	
	bounce_tween.tween_property(block, "position", start_pos, 0.12)\
		.set_trans(Tween.TRANS_QUAD)\
		.set_ease(Tween.EASE_IN)
	
	await bounce_tween.finished
	is_bouncing = false
"""

func bounce_up(block: AnimatableBody2D, marker1: Marker2D) -> void:
	if is_bouncing:
		return
 
	is_bouncing = true
	
	var back_SP: float = block.position.y
	
	var bounce_tween = create_tween()
	bounce_tween.tween_property(block, "global_position:y", marker1.global_position.y, 0.08)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	bounce_tween.tween_property(block, "global_position:y", back_SP, 0.08)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
func _on_push_up_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
		
	if body is CharacterBody2D:
		body.velocity.y = launch_force
		
	bounce_up(floor_3,$Marker2D)
