extends Node2D

@onready var floor_2: StaticBody2D = $"floor/floor 2"


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
	
	$"triggers/spiral 1 trig".set_deferred("monitoring", false)
	$"teleport/spiral 1".hide()
	$"teleport/spiral 1/Area2D".set_deferred("monitoring", false)
	
	
	
	
	
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
	
	tween.tween_property(floor_2, "global_position:x", $"floor 2 move".global_position.x, 1.0)


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
	tween.tween_property(floor_2, "global_position:x", $"floor 2 return".global_position.x, 1.0)
	
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
	tween.tween_property($"floor/floor 5 jump2", "global_position:y", $"floor 5 jump SP".global_position.y, 0.08)
	tween.tween_property($"floor/floor 5 jump2", "global_position:y", block_y, 0.08)


func _on_floor_5_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/floor 5 jumo trig".set_deferred("monitoring", true)
	$"triggers/floor 5 trig/CollisionShape2D".set_deferred("disabled", true)
	
	var tween = create_tween()
	tween.tween_property($"floor/floor 5", "global_position:x", $"floor 5 move".global_position.x, 0.5)


func _on_floor_5_jumo_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/floor 5 jumo trig/CollisionShape2D".set_deferred("disabled", true)
	
	var tween = create_tween()
	tween.tween_property($"floor/floor 5 jump", "global_position:x", $"floor 5 jump move".global_position.x, 1.0)
	
	await tween.finished
	
	$"floor/floor 5 jump2".show()
	$"floor/floor 5 jump2/CollisionShape2D".set_deferred("disabled", false)
	$"floor/floor 5 jump2/floor 5 jump".set_deferred("monitoring", true)


func _on_spiral_1_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/spiral 1 trig/CollisionShape2D".set_deferred("disabled", true)
	
	$"teleport/spiral 1".show()
	$"teleport/spiral 1/Area2D".set_deferred("monitoring", true)
	
func _on_floor_3_move_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
