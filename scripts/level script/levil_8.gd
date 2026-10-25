extends Node2D

@onready var player: CharacterBody2D = $player

@onready var trap_hide: Node2D = $"trap hide"

@onready var trap_show: Node2D = $"trap show"

func _ready() -> void:
	if player:
		# higher/faster jump
		player.JUMP_VELOCITY = -2000
		
		#floaty fall
		player.fall_gravity_multiplier = 1.0
		
	$"trap hide/up trap3".hide()
	$"trap hide/up trap4".hide()
	$"trap show/trap4".hide()
	
	
func _on_trap_3_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
		
	$"trap 3 trig/CollisionShape2D".set_deferred("disabled", true)
	trap_hide.get_children()[2].show()
	trap_hide.get_children()[3].show()

func _on_trap_4_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"trap 4 trig/CollisionShape2D".set_deferred("disabled", true)
	trap_show.get_child(3).show()
	
	var tween = create_tween()
	tween.tween_property($"trap show/trap5", "global_position:x", $"trap 4 SP".global_position.x, 0.1)


func _on_up_trap_6_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"up trap 6 trig/CollisionShape2D".set_deferred("disabled", true)
	
	var tween = create_tween()
	tween.tween_property($"trap hide/up trap6", "global_position:x", $"up trap 6".global_position.x, 0.1)

func _on_up_trap_7_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"up trap 7 trig/CollisionShape2D".set_deferred("disabled", true)
	var tween = create_tween().set_loops().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	
	tween.tween_property($"trap hide/up trap7", "global_position", $"up trap 7 SP stop".global_position, 0.9)\
	.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property($"trap hide/up trap7", "global_position", $"up trap 7 SP start".global_position, 0.9)\
	.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
