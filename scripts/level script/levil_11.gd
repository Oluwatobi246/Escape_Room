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
	$"floor 3/5".set_deferred("disabled", true)
	$"floor 3/5".hide()
	
	$"trap trig/trap 5 trig".set_deferred("monitoring", false)
	
	$traps/trap6.hide()
	$traps/trap6.set_deferred("monitoring", false)
	
	$traps/trap7.hide()
	$traps/trap7.set_deferred("monitoring", false)
	
	$"trap trig/trap 6 trig".set_deferred("monitoring", false)
	$"trap trig/trap 7 trig".set_deferred("monitoring", false)
	
	$"floor 4".hide()
	$"jump block3/jump block 3 trig".set_deferred("monitoring", false)
	$door.hide()
	
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
	
	if body is CharacterBody2D:
		body.velocity.y = jump_speed
	
	trap_2.show()
	trap_3.show()
	
	jump($"jump block", $"jump block end")
	

func _on_trap_4_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"trap trig/trap 4 trig/CollisionShape2D".set_deferred("disabled", true)
	$traps/trap4.show()


func _on_fake_door_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"trap trig/fake door trig/CollisionShape2D".set_deferred("disabled", true)
	
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
	$"floor 3/5".set_deferred("disabled", false)
	$"floor 3/5".show()
	
	$"trap trig/trap 5 trig".set_deferred("monitoring", true)

	$traps/trap6.set_deferred("monitoring", true)
	
	$traps/trap7.set_deferred("monitoring", true)
	
	$"trap trig/trap 6 trig".set_deferred("monitoring", true)
	$"trap trig/trap 7 trig".set_deferred("monitoring", true)
	
	$"jump block3/jump block 3 trig".set_deferred("monitoring", true)
	
func _on_trap_5_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"trap trig/trap 5 trig/CollisionShape2D".set_deferred("disabled", true)
	$traps/trap5.show()
	$traps/trap5.set_deferred("monitoring", true)


func _on_jump_block_2_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if body is CharacterBody2D:
		body.velocity.y = jump_speed
	
	trap_2.show()
	trap_3.show()
	
	jump($"jump block2", $"jump block 2 end")
	
func jump(block: AnimatableBody2D, target_marker: Marker2D) -> void:
	if is_bouncing:
		return

	is_bouncing = true
	
	var start_global_y: float = block.position.y

	var bounce_tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	bounce_tween.tween_property(block, "global_position:y", target_marker.global_position.y, 0.08)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	bounce_tween.tween_property(block, "global_position:y", start_global_y, 0.08)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	await bounce_tween.finished
	is_bouncing = false

func _on_trap_6_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"trap trig/trap 6 trig/CollisionShape2D".set_deferred("disabled", true)
	$traps/trap6.show()

func _on_trap_7_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"trap trig/trap 7 trig/CollisionShape2D".set_deferred("disabled", true)
	
	$traps/trap7.show()

func _on_jump_block_3_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
		
	$"floor 4".show()
	$door.show()
	
	if body is CharacterBody2D:
		body.velocity.y = jump_speed
	
	jump($"jump block3", $"jump block 3 end")
	
