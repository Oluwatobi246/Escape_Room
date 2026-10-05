extends Node2D

@onready var trap_floor_1: AnimatableBody2D = $"trap floor 1"
@onready var trap_floor_1_s_p: Marker2D = $"trap floor 1 S_P"
@onready var trap_floor_1_x: float = $"trap floor 1".position.x

@onready var trap_floor_2: AnimatableBody2D = $"trap floor 2"
@onready var trap_floor_2_s_p: Marker2D = $"trap floor 2 S_P"

@onready var wall_move_1: AnimatableBody2D = $"wall move 1"
@onready var wall_move_1_s_p: Marker2D = $"wall move 1 S_P"

@onready var wall_move_2: AnimatableBody2D = $"wall move 2"
@onready var wall_move_2_s_p: Marker2D = $"wall move 2 S_P"

@onready var key: Node2D = $Key
@onready var button: Area2D = $button

const CORRECT_ORDER: Array[String] = ["key 3", "key 2", "key 4", "key 1"]
var player_order: Array[String] = []

func _ready() -> void:
	trap_floor_2.hide()
	
	key.hide()
	for keys in key.get_children():
		if keys is Area2D:
			keys.get_node("CollisionShape2D").disabled = true
			

	if button:
		button.hide()
		button.get_node("CollisionShape2D").disabled = true
	
func _on_trap_floor_1_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"trap floor 1 trig/CollisionShape2D".set_deferred("disabled", true)
	var tween = create_tween()
	
	$"trap floor 1/AudioStreamPlayer2D".play()
	tween.tween_property(trap_floor_1, "position:x", position.x + 400, 0.5).as_relative()
	
	await get_tree().create_timer(1.0, false, true).timeout
	
	var rollback = create_tween()
	rollback.tween_property(trap_floor_1, "position:x", trap_floor_1_x, 0.5)
	$"trap floor 1/AudioStreamPlayer2D".play()
	await rollback.finished
	
func _on_death_2_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
		
	if body.has_method("die"):
		body.die()

func _on_wall_move_1_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	trap_floor_2.show()
	$"trap floor 2/AudioStreamPlayer2D".play()
	
	key.show()
	for keys in key.get_children():
		if keys is Area2D:
			keys.get_node("CollisionShape2D").set_deferred("disabled",false)
	$Key/AudioStreamPlayer2D.play()
	
	$"wall move 1 trig/CollisionShape2D".set_deferred("disabled", true)
	
	var wall_1_tween = create_tween()
	$"wall move 1/AudioStreamPlayer2D".play()
	wall_1_tween.tween_property(wall_move_1, "global_position:y", wall_move_1_s_p.global_position.y, 0.1)
	
	var wall_2_tween = create_tween()
	$"wall move 2/AudioStreamPlayer2D".play()
	wall_2_tween.tween_property(wall_move_2, "global_position:y", wall_move_2_s_p.global_position.y, 0.1)
	
	var trap_floor_tween = create_tween()
	trap_floor_tween.tween_property(trap_floor_2, "global_position:y", trap_floor_2_s_p.global_position.y, 22.0)

func handle_key_pressed(key_node: Area2D) -> void:
	# Prevent keys to be enetered twice
	if key_node.name in player_order:
		return
	
	#hide the key and turn off it's collision
	key_node.hide()
	key_node.get_node("CollisionShape2D").set_deferred("disabled", true)
	
	# Add the keys name
	player_order.append(key_node.name)
	
	# once all 4 keys are pressed check if the sequence is right.
	if player_order.size() == 4:
		check_sequence()


func _on_key_1_body_entered(body: Node2D) -> void:
	if body.name == "player" or body.is_in_group("player"):
		$Key/AudioStreamPlayer2D.play()
		handle_key_pressed($"Key/key 1")

func _on_key_2_body_entered(body: Node2D) -> void:
	if body.name == "player" or body.is_in_group("player"):
		$Key/AudioStreamPlayer2D.play()
		handle_key_pressed($"Key/key 2")

func _on_key_3_body_entered(body: Node2D) -> void:
	if body.name == "player" or body.is_in_group("player"):
		$Key/AudioStreamPlayer2D.play()
		handle_key_pressed($"Key/key 3")

func _on_key_4_body_entered(body: Node2D) -> void:
	if body.name == "player" or body.is_in_group("player"):
		$Key/AudioStreamPlayer2D.play()
		handle_key_pressed($"Key/key 4")

func check_sequence() -> void:
	if player_order == CORRECT_ORDER:
		button.show()
		button.get_node("CollisionShape2D").set_deferred("disabled", false)
	
	else:
		await get_tree().create_timer(1.0, false).timeout
		reset_all_keys()

func reset_all_keys():
	player_order.clear() # to clear all element in an array
	
	for keys in key.get_children():
		if keys is Area2D:
			keys.show()
			keys.get_node("CollisionShape2D").set_deferred("disabled", false)
