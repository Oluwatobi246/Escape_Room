extends Node2D

@onready var cover: AnimatableBody2D = $cover
@onready var saw: Area2D = $saw
@onready var saw_2: Area2D = $saw2
@onready var saw_3: Area2D = $saw3
@onready var saw_4: Area2D = $saw4
@onready var spike: Node2D = $spike


func _ready() -> void:
	$"spike trig".set_deferred("monitoring", false)

	$"saw 1 trig/saw 1 trig".set_deferred("monitoring", false)
	

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
	tween.tween_property(saw, "global_position:x", $"saw 1 movenment/Marker2D".global_position.x, 0.8)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(saw, "global_position:y", $"saw 1 movenment/Marker2D2".global_position.y, 0.8)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(saw, "global_position:x", $"saw 1 movenment/Marker2D3".global_position.x, 0.8)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(saw, "global_position:y", $"saw 1 movenment/Marker2D4".global_position.y, 0.8)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	$"spike trig".set_deferred("monitoring", true)
	
func _on_saw_1_trig_2_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"saw 1 trig/saw 1 trig2/CollisionShape2D".set_deferred("disabled", true)
	
	var tween = create_tween()
	tween.tween_property(saw, "global_position:x", $"saw 1 movenment/Marker2D".global_position.x, 0.8)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(saw, "global_position:y", $"saw 1 movenment/Marker2D2".global_position.y, 0.8)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(saw, "global_position:x", $"saw 1 movenment/Marker2D3".global_position.x, 0.8)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(saw, "global_position:y", $"saw 1 movenment/Marker2D4".global_position.y, 0.8)\
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
	tween.tween_property(cover, "global_position:x", $"cover movenment/Marker2D2".global_position.x, 1.0)


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
		var tween = create_tween()
		tween.tween_property(spikes, "global_position:y", $"spike SP".global_position.y, 0.05)

func _on_saw_1_resume_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"saw 1 trig/saw 1 Resume/CollisionShape2D".set_deferred("disabled", true)
	
	var tween = create_tween()
	tween.tween_property(saw, "global_position:y",$"saw 1 movenment/Marker2D3".global_position.y, 0.8)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(saw, "global_position:x", $"saw 1 movenment/Marker2D5".global_position.x, 0.8)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
