extends Node2D

@onready var cover: AnimatableBody2D = $cover
@onready var saw: Area2D = $saw
@onready var saw_2: Area2D = $saw2
@onready var saw_3: Area2D = $saw3
@onready var saw_4: Area2D = $saw4
@onready var spike: Node2D = $spike
@onready var saw_5: Area2D = $saw5
@onready var saw_6: Area2D = $saw6


func _ready() -> void:
	$"spike trig".set_deferred("monitoring", false)

	$"saw 1 trig/saw 1 trig".set_deferred("monitoring", false)
	
	$"block 2 open".set_deferred("monitoring", false)

	$"saw 2 block floor".hide()
	
	$"cover move 3".set_deferred("monitoring", false)
	$"cover move 3 open".set_deferred("monitoring", false)
	
	$"saw 3 trigs/saw 3 block".hide()
	
	$"saw 5 trig/saw 5 block".hide()
	
	$saw6.hide()
	
	$"block 2 trig".set_deferred("monitoring", false)
	
func _on_cover_1_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"cover 1/CollisionShape2D".set_deferred("disabled", true)
	
	var tween = create_tween()
	tween.tween_property(cover,"global_position:x",$"cover movenment/Marker2D".global_position.x, 1.5)

	
func _on_saw_1_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"saw 1 trig/saw 1 trig/CollisionShape2D".set_deferred("disabled", true)
	
	var tween = create_tween()
	tween.tween_property(saw, "global_position:x", $"saw 1 movenment/Marker2D".global_position.x, 0.5)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(saw, "global_position:y", $"saw 1 movenment/Marker2D2".global_position.y, 0.5)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(saw, "global_position:x", $"saw 1 movenment/Marker2D3".global_position.x, 0.5)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(saw, "global_position:y", $"saw 1 movenment/Marker2D4".global_position.y, 0.5)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	$"spike trig".set_deferred("monitoring", true)
	
func _on_saw_1_trig_2_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"saw 1 trig/saw 1 trig2/CollisionShape2D".set_deferred("disabled", true)
	
	var tween = create_tween()
	tween.tween_property(saw, "global_position:x", $"saw 1 movenment/Marker2D".global_position.x, 0.5)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(saw, "global_position:y", $"saw 1 movenment/Marker2D2".global_position.y, 0.5)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(saw, "global_position:x", $"saw 1 movenment/Marker2D3".global_position.x, 0.5)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(saw, "global_position:y", $"saw 1 movenment/Marker2D4".global_position.y, 0.5)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)


func _on_saw_1_trig_cm_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"saw 1 trig/saw 1 trig CM/CollisionShape2D".set_deferred("disabled", true)
	
	$"saw 1 trig/saw 1 trig".set_deferred("monitoring", true)


func _on_cover_2_area_entered(area: Area2D) -> void:
	if not (area.name == "saw" or area.is_in_group("saw")):
		return
	
	$"cover 2/CollisionShape2D".set_deferred("disabled", false)
	
	var tween = create_tween()
	tween.tween_property(cover, "global_position:x", $"cover movenment/Marker2D2".global_position.x, 0.5)


func _on_block_7_trig_area_entered(area: Area2D) -> void:
	if not (area.name == "saw" or area.is_in_group("saw")):
		return
	
	$"block 7 trig/CollisionShape2D".set_deferred("disabled", true)
	$"floor 4/7".hide()
	$"floor 4/CollisionShape2D7".set_deferred("disabled", true)

func _on_spike_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
		
	$"spike trig/CollisionShape2D".set_deferred("disabled", true)
	
	for spikes in spike.get_children():
		$"spike trig/AudioStreamPlayer2D".play()
		var tween = create_tween()
		tween.tween_property(spikes, "global_position:y", $"spike SP".global_position.y, 0.05)
	
func _on_saw_1_resume_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"saw 1 trig/saw 1 Resume/CollisionShape2D".set_deferred("disabled", true)
	$"block 2 open".set_deferred("monitoring", true)
	
	var tween = create_tween()
	tween.tween_property(saw, "global_position:y",$"saw 1 movenment/Marker2D3".global_position.y, 0.7)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(saw, "global_position:x", $"saw 1 movenment/Marker2D5".global_position.x, 1.0)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	
func _on_block_2_open_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"block 2 open/CollisionShape2D".set_deferred("disabled", true)
	$"cover move 3 open".set_deferred("monitoring", true)
	
	$"floor 4/2".hide()
	$"floor 4/CollisionShape2D2".set_deferred("disabled", true)


func _on_cover_move_3_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"cover move 3/CollisionShape2D".set_deferred("disabled", true)
	
	var tween = create_tween()
	tween.tween_property(cover, "global_position:x", $"cover movenment/Marker2D3".global_position.x, 3.0)


func _on_starting_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"saw 2 trig/starting trig/CollisionShape2D".set_deferred("disabled", true)
	
	var tween = create_tween()
	tween.tween_property(saw_2, "global_position:y", $"saw 2 movenment/Marker2D".global_position.y, 0.5)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(saw_2, "global_position:x", $"saw 2 movenment/Marker2D2".global_position.x, 3.4)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)


func _on_saw_2_block_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"saw 2 block trig/CollisionShape2D".set_deferred("disabled", true)
	$"saw 2 block floor".show()
	
	
func _on_cover_move_3_open_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
		
	$"cover move 3".set_deferred("monitoring", true)


func _on_saw_3_start_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"saw 3 trigs/saw 3 start/CollisionShape2D".set_deferred("disabled", true)
	
	var tween = create_tween()
	tween.tween_property(saw_3, "global_position:x", $"saw 3 movenment/Marker2D".global_position.x, 2.1)

func _on_saw_3_block_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"saw 3 trigs/saw 3 block trig/CollisionShape2D".set_deferred("disabled", true)
	$"saw 3 trigs/saw 3 block".show()
	
func _on_saw_4_start_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"saw 4 trig/saw 4 start/CollisionShape2D".set_deferred("disabled", true)
	
	var tween = create_tween()
	tween.tween_property(saw_4, "global_position:x", $"saw 4 movenment/Marker2D".global_position.x, 2.109)


func _on_floor_6_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"floor 6 trig/CollisionShape2D".set_deferred("disabled", true)
	
	$"floor 6".hide()
	$"floor 6".get_node("CollisionShape2D").set_deferred("disabled", true)
	
	for spikes in spike.get_children():
		spikes.hide()
		spikes.get_node("CollisionShape2D").set_deferred("disabled", true)


func _on_saw_5_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"saw 5 trig/saw 5/CollisionShape2D".set_deferred("disabled", true)
	
	var tween = create_tween()
	tween.tween_property(saw_5, "global_position:x", $"saw 5 movenment/new move 1".global_position.x, 2.4)
	tween.tween_property(saw_5, "global_position:y", $"saw 5 movenment/new move 2".global_position.y, 2.0)


func _on_saw_5_block_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"saw 5 trig/saw 5 block trig/CollisionShape2D".set_deferred("disabled", true)
	$"saw 5 trig/saw 5 block".show()


func _on_saw_6_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"saw 6 trig/CollisionShape2D".set_deferred("disabled", true)
	$saw6.show()
	
	$"block 2 trig".set_deferred("monitoring", true)
	
	var tween = create_tween()
	tween.tween_property(saw_6, "global_position:x", $"saw 6 movenment/Marker2D".global_position.x, 3.5)
	tween.tween_property(saw_6, "global_position:y", $"saw 6 movenment/Marker2D2".global_position.y, 2.4)


func _on_block_2_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"block 2 trig/CollisionShape2D".set_deferred("disabled", true)

	$"floor 2/2".hide()
	$"floor 2/CollisionShape2D2".set_deferred("disabled", true)
