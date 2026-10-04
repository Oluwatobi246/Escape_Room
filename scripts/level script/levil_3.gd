extends Node2D
@onready var trap_1: Area2D = $"trap 1"
@onready var trap_2: Area2D = $"trap 2"
@onready var trap_1_pos: Marker2D = $"trap 1 pos"

@onready var wall_move_pos: Marker2D = $"wall move pos"
@onready var wall_close: AnimatableBody2D = $"wall close"

@onready var move_wall_2: AnimatableBody2D = $"move wall 2"
@onready var move_wall_2_pos: Marker2D = $"move wall 2 pos"

@onready var trap_wall: AnimatableBody2D = $"trap wall"
@onready var trap_wall_pos: Marker2D = $"trap wall pos"

@onready var button: Area2D = $button

@onready var floor_trap_1: AnimatableBody2D = $"floor trap 1"
@onready var floor_move_pos: Marker2D = $"floor move pos"



var move_wall_2_y: float
var floor_trap_1_x: float

func _ready() -> void:
	get_tree().paused = false
	trap_2.hide()
	trap_2.monitoring = false
	
	trap_wall.hide()
	button.hide()
	
	move_wall_2_y = move_wall_2.position.y
	floor_trap_1_x = floor_trap_1.position.x

func _on_trap_1_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	$"trap 1 trig/CollisionShape2D".set_deferred("disabled", true)
	$"trap 1 trig real/CollisionShape2D".set_deferred("disabled", true)
	
	var tween = create_tween()
	tween.tween_property(trap_1, "global_position:x", trap_1_pos.global_position.x, 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func _on_trap_1_trig_real_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	$"trap 1 trig real/CollisionShape2D".set_deferred("disabled", true)
	$"trap 1 trig/CollisionShape2D".set_deferred("disabled", true)
	
	var tween = create_tween()
	tween.tween_property(trap_1, "global_position:x", trap_1_pos.global_position.x, 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func _on_trap_2_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	$"trap 2 trig/CollisionShape2D".set_deferred("disabled", true)
	trap_2.show()
	trap_2.monitoring = true
	
	$wallclosesound.play()
	var wall_tween = create_tween()
	wall_tween.tween_property(wall_close, "global_position:x", wall_move_pos.global_position.x, 0.2)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(trap_1, "global_position:x", -300, 2.0).as_relative()
	tween.tween_property(trap_2, "global_position:x", -400, 2.0).as_relative()

func _on_move_wall_2_trig_area_entered(area: Area2D) -> void:
	if area.name == "trap 2":
		$"move wall 2 trig/CollisionShape2D".set_deferred("disabled", true)
		$walldownsound.play()
		var tween = create_tween()
		tween.tween_property(move_wall_2, "global_position:y", move_wall_2_pos.global_position.y, 0.2)

func _on_traps_vanish_area_entered(area: Area2D) -> void:
	if area.name == "trap 1":
		area.queue_free()
	
	if area.name == "trap 2":
		$"traps vanish/CollisionShape2D".set_deferred("disabled", true)
		area.queue_free()
		
func _on_trap_wall_trig_area_entered(area: Area2D) -> void:
	if area.name == "trap 2":
		$"block way/CollisionShape2D".set_deferred("disabled",true)
		trap_wall.show()
		$"trap wall trig/CollisionShape2D".set_deferred("disabled",true)
		
		$spikewallsound.play()
		
		var tween = create_tween()
		tween.tween_property(trap_wall, "global_position:y", trap_wall_pos.global_position.y, 7.7)
		
		await tween.finished
		$spikewallsound.stop()
		
func _on_button_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"button sound".play()
	button.show()
	$"button trig/CollisionShape2D".set_deferred("disabled", true)
	
func _on_button_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	button.hide()
	
	$wallupsound.play()
	
	var tween = create_tween()
	tween.tween_property(move_wall_2, "position:y", move_wall_2_y, 0.2)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func _on_trap_wall_death_body_entered(body: Node2D) -> void:
	if body.name == "player" or body.is_in_group("player"):
		if body.has_method("die"):
			body.die()

func _on_floor_trap_1_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	var tween = create_tween()
	tween.tween_property(floor_trap_1, "global_position:x", floor_move_pos.global_position.x, 0.2)
	
	await get_tree().create_timer(1.5).timeout
	
	var back = create_tween()
	back.tween_property(floor_trap_1, "global_position:x", floor_trap_1_x, 0.2)

func _on_death_body_entered(body: Node2D) -> void:
	if body.name == "player" or body.is_in_group("player"):
		if body.has_method("die"):
			body.die()
