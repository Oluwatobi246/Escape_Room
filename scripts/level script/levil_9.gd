extends Node2D

@onready var push_up: AnimatableBody2D = $"floor 3/push up"
@onready var player: CharacterBody2D = $player
@onready var floor_3: AnimatableBody2D = $"floor 3"
@onready var floor_5: AnimatableBody2D = $"floor 5"

var is_bouncing: bool = false
var launch_force: float = -650.0

func _ready() -> void:
	$"count trig CB".get_node("CollisionShape2D").set_deferred("disabled", true)

func _on_death_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if body.has_method("die"):
		body.die()

func bounce_up(block: AnimatableBody2D, target_marker: Marker2D) -> void:
	if is_bouncing:
		return
 
	is_bouncing = true
	
	var start_global_y: float = block.position.y
	
	var bounce_tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	bounce_tween.tween_property(block, "global_position:y", target_marker.global_position.y, 0.08)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	bounce_tween.tween_property(block, "global_position:y", start_global_y, 0.08)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	await bounce_tween.finished
	is_bouncing = false

func _on_push_up_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if body is CharacterBody2D:
		body.velocity.y = launch_force
	
	bounce_up(floor_3, $"floor 3 S_P")


func _on_floor_3_m_t_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
		
	$"floor 3 M T".get_node("CollisionShape2D").set_deferred("disabled", true)
	$"floor 3/push up".get_node("CollisionShape2D").set_deferred("disabled", true)
	
	var tween = create_tween().set_parallel(true)
	tween.tween_property(floor_3, "global_position:x",$"floor 3 SP".global_position.x, 0.08)
	tween.tween_property(floor_5, "global_position:x",$"floor 5 SP".global_position.x, 0.08)
	
	await tween.finished

func _on_count_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"count trig".set_deferred("monitoring", false)
	$"count trig/CollisionShape2D".set_deferred("disabled", true)
	$"count trig CB/CollisionShape2D".set_deferred("disabled", false)
	
func _on_count_trig_cb_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"count trig CB".set_deferred("monitoring", false)
	
	var tween = create_tween().set_parallel(true)
	tween.tween_property(floor_3, "global_position:x",$"floor 3 SP ED".global_position.x, 5.0)
	tween.tween_property(floor_5, "global_position:x",$"floor 5 SP ED".global_position.x, 5.0)
	
