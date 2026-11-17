extends Node2D

@onready var floor_2: AnimatableBody2D = $"floor/floor 2"
@onready var floor_2_x: float = $"floor/floor 2".global_position.x

func _ready() -> void:
	$"triggers/floor 2 jump".set_deferred("monitoring", false)
	
	$"floor/floor 2 jump".hide()
	$"floor/floor 2 jump".get_node("CollisionShape2D").set_deferred("disabled", true)


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
	
