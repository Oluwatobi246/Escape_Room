extends Node2D
@onready var fake_door: Area2D = $"fake door"

@onready var button: AnimatableBody2D = $"Button System/button"
@onready var button_pos: Marker2D = $"Button System/button pos"

@onready var spike_chain: Node2D = $"spike chain"
@onready var spike_chain_2: Node2D = $"spike chain2"

@onready var button_sound: AudioStreamPlayer2D = $"button sound"
@onready var spike_sound: AudioStreamPlayer2D = $"spike sound"

func _ready() -> void:
	for trap in spike_chain.get_children():
		trap.hide()
		trap.monitoring = false
	
	$"spike chain trig/CollisionShape2D".set_deferred("disabled", true)
	
	for traps in spike_chain_2.get_children():
		traps.hide()
		traps.monitoring = false

func _on_fake_door_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"spike chain trig/CollisionShape2D".set_deferred("disabled", false)
	$"fake door trig/CollisionShape2D".set_deferred("disabled",true)
	$"Button System/button/button trigger/CollisionShape2D2".set_deferred("disabled", false)
	
	button_sound.play()
	var tween = create_tween()
	tween.tween_property(button,"global_position:y", button_pos.global_position.y, 0.2)
	
	fake_door.queue_free()
	
func _on_spike_chain_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	# Loop through every single trap inside spike_chain automatically in order!
	for trap in spike_chain.get_children():
		trap.show()
		trap.monitoring = true
		
		spike_sound.play()
		# Small delay between each spike so they pop up like a wave!
		await get_tree().create_timer(0.1, false, false, true).timeout

func _on_button_trigger_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"down floor".hide()
	button.hide()
	$"floor 2 move".hide()
	$"floor 2 move/CollisionShape2D".set_deferred("disabled", true)
	$"Button System/button/button trigger/CollisionShape2D2".set_deferred("disabled", true)
	await get_tree().create_timer(0.5).timeout
	$"top floor".show()

func _on_spike_chain_2_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
		
	$"spike chain 2 trig/CollisionShape2D".set_deferred("disabled", true)
	
	# Get all trap children from the second spike chain
	var traps = spike_chain_2.get_children()
	traps.reverse()
	
	for trap in traps:
		trap.show()
		trap.monitoring = true
		spike_sound.play()
		await get_tree().create_timer(0.1, false, false, true).timeout
	
