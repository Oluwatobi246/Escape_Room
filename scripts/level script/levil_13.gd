extends Node2D

@onready var floor_2: StaticBody2D = $"floor/floor 2"
@onready var traps: Node2D = $traps


func _ready() -> void:
	$"triggers/floor 2 jump".set_deferred("monitoring", false)
	
	$"floor/floor 2 jump".hide()
	$"floor/floor 2 jump".get_node("CollisionShape2D").set_deferred("disabled", true)

	$"floor/background 2".hide()

	$"floor/floor 2 v 2".hide()
	$"floor/floor 2 v 2".get_node("CollisionShape2D").set_deferred("disabled", true)
	
	$"floor/floor 5 jump2".hide()
	$"floor/floor 5 jump2/CollisionShape2D".set_deferred("disabled", true)
	$"floor/floor 5 jump2/floor 5 jump".set_deferred("monitoring", false)
	
	$"triggers/floor 5 jumo trig".set_deferred("monitoring", false)
	
	$"floor/floor 4".hide()
	$"floor/floor 4".get_node("CollisionShape2D").set_deferred("disabled", true)
	
	$"floor/floor 5".hide()
	$"floor/floor 5".get_node("CollisionShape2D").set_deferred("disabled", true)
	
	$"floor/floor 5 jump".hide()
	$"floor/floor 5 jump".get_node("CollisionShape2D").set_deferred("disabled", true)
	
	$"triggers/spiral 1 trig".set_deferred("monitoring", true)
	$"teleport/spiral 1".hide()
	$"teleport/spiral 1/spiral 1".set_deferred("monitoring", false)
	
	$"teleport/spiral 2".hide()
	$"teleport/spiral 2/spiral 2".set_deferred("monitoring", false)
	
	$"teleport/spiral 3".hide()
	$"teleport/spiral 3/spiral 3".set_deferred("monitoring", false)
	
	$"teleport/spiral 4".hide()
	$"teleport/spiral 4/spiral 4".set_deferred("monitoring", false)
	
	$"triggers/spiral 4 trig".set_deferred("monitoring", false)
	
	$"triggers/trap 910 trig".set_deferred("monitoring", false)
	
	for trap in traps.get_children():
		if trap is Area2D:
			trap.hide()
			trap.set_deferred("monitoring", false)
	
	
	
func _on_death_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if body.has_method("die"):
		body.die()


func _on_floor_2_move_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/floor 2 move/CollisionShape2D".set_deferred("disabled", true)
	$"triggers/floor 2 jump".set_deferred("monitoring", true)
	
	var tween = create_tween()
	
	tween.tween_property(floor_2, "global_position:x", $"markers/floor 2 move".global_position.x, 1.0)


func _on_floor_2_jump_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/floor 2 jump/StaticBody2D".set_deferred("disabled", true)
	
	$"floor/floor 2 jump".show()
	$"floor/floor 2 jump".get_node("CollisionShape2D").set_deferred("disabled", false)
	
	await get_tree().create_timer(2.0, false).timeout
	
	$"floor/floor 2 jump".hide()
	$"floor/floor 2 jump".get_node("CollisionShape2D").set_deferred("disabled", true)

func _on_floor_2_back_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/floor 2 back/CollisionShape2D".set_deferred("disabled", true)
	$"floor/background 2".show()
	
	var tween = create_tween()
	tween.tween_property(floor_2, "global_position:x", $"markers/floor 2 return".global_position.x, 1.0)
	
	await tween.finished
	
	$"floor/background 2".hide()
	
	$"floor/floor 2".hide()
	$"floor/floor 2".get_node("CollisionShape2D").set_deferred("disabled", true)
	
	$"floor/floor 2 v 2".show()
	$"floor/floor 2 v 2".get_node("CollisionShape2D").set_deferred("disabled", false)
	
	await get_tree().create_timer(2.5, false).timeout
	
	$"floor/floor 4".show()
	$"floor/floor 4".get_node("CollisionShape2D").set_deferred("disabled", false)
	
	$"floor/floor 5".show()
	$"floor/floor 5".get_node("CollisionShape2D").set_deferred("disabled", false)
	
	$"floor/floor 5 jump".show()
	$"floor/floor 5 jump".get_node("CollisionShape2D").set_deferred("disabled", false)

func _on_floor_5_jump_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if body is CharacterBody2D:
		body.velocity.y = -450
	
	var block_y = $"floor/floor 5 jump2".global_position.y
	
	var tween = create_tween()
	tween.tween_property($"floor/floor 5 jump2", "global_position:y", $"markers/floor 5 jump SP".global_position.y, 0.08)
	tween.tween_property($"floor/floor 5 jump2", "global_position:y", block_y, 0.08)


func _on_floor_5_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/floor 5 jumo trig".set_deferred("monitoring", true)
	$"triggers/floor 5 trig/CollisionShape2D".set_deferred("disabled", true)
	
	var tween = create_tween()
	tween.tween_property($"floor/floor 5", "global_position:x", $"markers/floor 5 move".global_position.x, 0.5)


func _on_floor_5_jumo_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/floor 5 jumo trig/CollisionShape2D".set_deferred("disabled", true)
	
	var tween = create_tween()
	tween.tween_property($"floor/floor 5 jump", "global_position:x", $"markers/floor 5 jump move".global_position.x, 1.0)
	
	await tween.finished
	
	$"floor/floor 5 jump2".show()
	$"floor/floor 5 jump2/CollisionShape2D".set_deferred("disabled", false)
	$"floor/floor 5 jump2/floor 5 jump".set_deferred("monitoring", true)


func _on_spiral_1_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/spiral 1 trig/CollisionShape2D".set_deferred("disabled", true)
	
	$"teleport/spiral 1".show()
	$"teleport/spiral 1/spiral 1".set_deferred("monitoring", true)
	
	$"triggers/trap 910 trig".set_deferred("monitoring", true)
	
func _on_floor_3_move_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/floor 3 move/CollisionShape2D".set_deferred("disabled", true)
	
	var moving = create_tween().set_parallel(true)
	
	moving.tween_property($"floor 3", "global_position:y", $"markers/floor 3 move".global_position.y, 7.0)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	moving.tween_property($floor, "global_position:y", $"markers/floor general move".global_position.y, 7.0)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	moving.tween_property($"floor part 2", "global_position:y", $"markers/Next floor".global_position.y, 7.0)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	await moving.finished
	
	for trap in traps.get_children():
		if trap is Area2D:
			trap.show()
			trap.set_deferred("monitoring", true)
	
	$door.show()

func _on_trap_910_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/trap 910 trig/CollisionShape2D".set_deferred("disabled", true)
	
	$traps/trap9.hide()
	$traps/trap9.set_deferred("monitoring", false)
	$traps/trap10.hide()
	$traps/trap10.set_deferred("monitoring", false)
	
	await get_tree().create_timer(2.0, false).timeout

	$"teleport/spiral 2".show()
	$"teleport/spiral 2/spiral 2".set_deferred("monitoring", true)
	

func _on_spiral_1_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"teleport/spiral 1/spiral 1/CollisionShape2D".set_deferred("disabled", true)
	
	body.hide()
	
	if body is CharacterBody2D:
		body.velocity = Vector2.ZERO
		body.set_physics_process(false)
		

	await get_tree().create_timer(0.5, false).timeout
	
	body.global_position = $"markers/spiral tel SP".global_position
	if body is CharacterBody2D:
		body.set_physics_process(true)
	body.show()
	

func _on_spiral_2_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	body.hide()
	await get_tree().create_timer(1.0, false).timeout
	
	body.global_position = $"markers/spiral tel 2  SP".global_position
	body.show()


func _on_spiral_3_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/spiral 3 trig/CollisionShape2D".set_deferred("disabled", true)
	$"triggers/spiral 4 trig".set_deferred("monitoring", true)
	
	$"teleport/spiral 3".show()
	$"teleport/spiral 3/spiral 3".set_deferred("monitoring", true)


func _on_spiral_3_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"teleport/spiral 3/spiral 3/CollisionShape2D".set_deferred("disabled", true)
	
	body.hide()
	await get_tree().create_timer(1.0, false).timeout
	
	body.global_position = $"markers/spiral tel 3  SP".global_position
	body.show()


func _on_spiral_4_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"teleport/spiral 4/spiral 4/CollisionShape2D".set_deferred("disabled", true)
	
	body.hide()
	await get_tree().create_timer(1.0, false).timeout
	
	body.global_position = $"markers/spiral tel 4 SP".global_position
	body.show()


func _on_spiral_4_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
		
	$"floor part 2/ColorRect".hide()
	$"triggers/spiral 4 trig/CollisionShape2D".set_deferred("disabled", true)
	
	$"teleport/spiral 3".hide()
	$"teleport/spiral 3/spiral 3".set_deferred("monitoring", false)
	
	$"teleport/spiral 4".show()
	$"teleport/spiral 4/spiral 4".set_deferred("monitoring", true)
