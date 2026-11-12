extends Node2D

var is_bouncing: bool = false
var jump_speed: float = -500.0

func _ready() -> void:
	pass

func bounce_up(block: AnimatableBody2D, target_marker: Marker2D) -> void:
	if is_bouncing:
		return
 
	is_bouncing = true
	
	var start_global_y: float = block.position.y
	$"sound/JB sound".play()
	var bounce_tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	bounce_tween.tween_property(block, "global_position:y", target_marker.global_position.y, 0.08)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	bounce_tween.tween_property(block, "global_position:y", start_global_y, 0.08)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	await bounce_tween.finished
	is_bouncing = false

func _on_j_b_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if body is CharacterBody2D:
		body.velocity.y = jump_speed
		
	bounce_up($"jump blocks/J B", $"markers/J B end")
	
func _on_floor_7_trg_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/floor 7 trg/CollisionShape2D".set_deferred("disabled", true)
	
	$"floor/floor 7".get_node("CollisionShape2D").set_deferred("disabled", true)
	$"floor/floor 7".hide()

func _on_spiral_1_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
		
	body.hide()
	await get_tree().create_timer(1.0, false).timeout
	
	body.global_position = $"markers/fall 1".global_position
	
	
