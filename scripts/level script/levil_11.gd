extends Node2D

@onready var player: CharacterBody2D = $player

@onready var trap_2: Area2D = $traps/trap2
@onready var trap_3: Area2D = $traps/trap3

@onready var jump_block: AnimatableBody2D = $"jump block"
@onready var jump_block_2: AnimatableBody2D = $"jump block2"

var jump_speed: float = -900
var is_bouncing: bool = false

func _ready() -> void:
	$traps/trap.hide()
	trap_2.hide()
	trap_3.hide()

	$traps/trap4.hide()
	
	$traps/trap5.hide()
	$traps/trap5.set_deferred("monitoring", false)
	
	$"floor 3".hide()
	$"floor 3/1".set_deferred("disabled", true)
	$"floor 3/1".hide()
	$"floor 3/2".set_deferred("disabled", true)
	$"floor 3/2".hide()
	$"floor 3/3".set_deferred("disabled", true)
	$"floor 3/3".hide()
	$"floor 3/4".set_deferred("disabled", true)
	$"floor 3/4".hide()
	
	$"trap trig/trap 5 trig".set_deferred("monitoring", false)
	
func _on_death_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if body.has_method("die"):
		body.die()

func _on_trap_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	$"trap trig/trap trig/CollisionShape2D".set_deferred("disabled", true)
	$traps/trap.show()

func _on_jump_block_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if is_bouncing:
		return
 
	is_bouncing = true
	
	if body is CharacterBody2D:
		body.velocity.y = jump_speed
	
	trap_2.show()
	trap_3.show()
	
	var start_global_y: float = jump_block.position.y
	
	$"jump block sound".play()
	
	var bounce_tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	bounce_tween.tween_property(jump_block, "global_position:y", $"jump block end".global_position.y, 0.08)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	bounce_tween.tween_property(jump_block, "global_position:y", start_global_y, 0.08)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	await bounce_tween.finished
	is_bouncing = false
	

func _on_trap_4_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"trap trig/trap 4 trig/CollisionShape2D".set_deferred("disabled", true)
	$traps/trap4.show()


func _on_fake_door_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"fake door".hide()
	$traps/trap4.hide()
	$traps/trap4.set_deferred("monitoring", false)
	
	$traps/trap.set_deferred("monitoring", false)
	$traps/trap.hide()
	
	$traps/trap2.hide()
	
	$traps/trap3.hide()
	
	$"floor 2".queue_free()
	
	$"jump block".queue_free()
	
	$"floor 3".show()
	$"floor 3/1".set_deferred("disabled", false)
	$"floor 3/1".show()
	$"floor 3/2".set_deferred("disabled", false)
	$"floor 3/2".show()
	$"floor 3/3".set_deferred("disabled", false)
	$"floor 3/3".show()
	$"floor 3/4".set_deferred("disabled", false)
	$"floor 3/4".show()


func _on_trap_5_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"trap trig/trap 5 trig/CollisionShape2D".set_deferred("disabled", true)
	$traps/trap5.show()
	$"trap trig/trap 5 trig".set_deferred("monitoring", true)


func _on_jump_block_2_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if is_bouncing:
		return
 
	is_bouncing = true
	
	if body is CharacterBody2D:
		body.velocity.y = jump_speed
	
	trap_2.show()
	
	trap_3.show()
		
	var start_global_y: float = jump_block_2.global_position.y
	
	$"jump block sound".play()
	
	var bounce_tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	bounce_tween.tween_property(jump_block, "global_position:y", $"jump block 2 end".global_position.y, 0.08)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	bounce_tween.tween_property(jump_block, "global_position:y", start_global_y, 0.08)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	await bounce_tween.finished
	is_bouncing = false
	
	
