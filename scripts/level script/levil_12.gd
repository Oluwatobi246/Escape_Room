extends Node2D

@onready var trap: Node2D = $"floor/floor 10/trap"
@onready var floor_10: AnimatableBody2D = $"floor/floor 10"


var is_bouncing: bool = false
var jump_speed: float = -500.0

func _ready() -> void:
	$saw.set_deferred("monitoring", false)
	$saw.hide()
	
	$trap.hide()
	$trap.set_deferred("monitoring", false)
	
	for traps in trap.get_children():
		if traps is Area2D:
			traps.hide()
			traps.set_deferred("monitoring", false)
	
	$"floor/floor 11".hide()
	
	$"spiral/spiral 2".hide()
	
	$trap2.hide()
	
func _on_death_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if body.has_method("die"):
		body.die()
	
	
func bounce_up(block: AnimatableBody2D, target_marker: Marker2D) -> void:
	if is_bouncing:
		return
 
	is_bouncing = true
	
	var start_global_y: float = block.global_position.y
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
	body.show()
	

func _on_floor_6_3_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/floor 6_3/CollisionShape2D".set_deferred("disabled", true)
	$"floor/floor 6/3".hide()
	$"floor/floor 6/CollisionShape2D3".set_deferred("disabled", true)
	
	await get_tree().create_timer(1.5, false).timeout
	
	$"floor/floor 6/3".show()
	$"floor/floor 6/CollisionShape2D3".set_deferred("disabled", false)


func _on_floor_4_v_4_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/floor 4 v4/CollisionShape2D".set_deferred("disabled", true)
	
	$"floor/floor 4/4".hide()
	$"floor/floor 4/CollisionShape2D4".set_deferred("disabled", true)
	
	
func _on_saw_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/saw trig/CollisionShape2D".set_deferred("disabled", true)
	await get_tree().create_timer(1.0).timeout
	
	$saw.set_deferred("monitoring", true)
	$saw.show()
	
	var tween = create_tween()
	tween.tween_property($saw, "global_position:x", $"markers/saw end".global_position.x, 0.2)
	
	await tween.finished
	$saw.queue_free()


func _on_j_b_2_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if body is CharacterBody2D:
		body.velocity.y = jump_speed
		
	bounce_up($"jump blocks/J B2", $"markers/J B 2 end")

func _on_trap_1_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/trap 1/CollisionShape2D".set_deferred("disabled", true)
	
	$trap.show()
	$trap.set_deferred("monitoring", true)

func _on_j_b_3_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if body is CharacterBody2D:
		body.velocity.y = jump_speed
	
	bounce_up($"jump blocks/J B3", $"markers/J B 3 end")

func _on__death_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if body.has_method("die"):
		body.die()
	

func _on_trap_10_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/trap 10 trig/CollisionShape2D".set_deferred("disabled", true)
	var floor_10_y = floor_10.global_position.y
	var tween = create_tween()
	tween.tween_property(floor_10, "global_position:y", $"markers/floor 10 land".global_position.y, 0.2)
	
	await tween.finished
	await get_tree().create_timer(1.5, false).timeout
	
	var return_tween = create_tween()
	return_tween.tween_property(floor_10, "global_position:y", floor_10_y, 0.5)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)


func _on_trap_10_move_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
		
	$floor/ColorRect2.hide()
	$"triggers/trap 10 move trig/CollisionShape2D".set_deferred("disabled", true)
	
	for traps in trap.get_children():
		if traps is Area2D:
			traps.show()
			traps.set_deferred("monitoring", true)
	
	var tween = create_tween()
	tween.tween_property(floor_10, "global_position:y", $"markers/floor 10 land".global_position.y, 0.2)
	
	await tween.finished
	
	var move_tween = create_tween()
	move_tween.tween_property(floor_10, "global_position:x", $"markers/floor 10 end".global_position.x, 1.9)
	

func _on_floor_11_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/floor 11 trig/CollisionShape2D".set_deferred("disabled", true)
	
	$"floor/floor 11".show()

func _on_floor_4_2_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/floor 4 2/CollisionShape2D".set_deferred("disabled", true)
	
	$"floor/floor 4/2".hide()
	$"floor/floor 4/CollisionShape2D2".set_deferred("disabled", true)
	
func _on_j_b_4_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if body is CharacterBody2D:
		body.velocity.y = jump_speed
		
	bounce_up($"jump blocks/J B4", $"markers/J B 4 end")


func _on_spiral_2_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	body.hide()
	await get_tree().create_timer(1.0, false).timeout
	
	body.global_position = $"markers/fall 2".global_position
	body.show()

func _on_spiral_2_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/spiral 2 trig/CollisionShape2D".set_deferred("disabled", true)
	
	$"spiral/spiral 2".show()
	
	await get_tree().create_timer(2.0, false).timeout
	
	$"spiral/spiral 2".hide()
	$"spiral/spiral 2/CollisionShape2D".set_deferred("disabled", true)
	$"spiral/spiral 2".set_deferred("monitoring", false)


func _on_trap_2_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/trap 2 trig/CollisionShape2D".set_deferred("disabled", true)
	
	$trap2.show()
