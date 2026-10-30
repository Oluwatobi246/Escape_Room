extends Node2D

@onready var push_up: AnimatableBody2D = $"floor 3/push up"
@onready var player: CharacterBody2D = $player
@onready var floor_3: AnimatableBody2D = $"floor 3"

var is_bouncing: bool = false
var launch_force: float = -650.0
const resting_scale: float = 0.50

func _ready() -> void:
	if floor_3:
		Vector2(0, -50)

func bounce_up(block: AnimatableBody2D) -> void:
	if is_bouncing:
		return
	
	is_bouncing = true
	
	var bounce_tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	bounce_tween.tween_property(block, "scale:y", 1.0, 0.08)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	bounce_tween.tween_property(block, "position", resting_scale, 0.08)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	
	await bounce_tween.finished
	is_bouncing = false
	
func _on_push_up_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
		
	if body is CharacterBody2D:
		body.velocity.y = launch_force
		
	bounce_up($"floor 3")
