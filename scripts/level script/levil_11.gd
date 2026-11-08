extends Node2D

@onready var player: CharacterBody2D = $player

@onready var trap_2: Area2D = $traps/trap2
@onready var trap_3: Area2D = $traps/trap3

@onready var jump_block: AnimatableBody2D = $"jump block"

var jump_speed: float = -600

func _ready() -> void:
	$traps/trap.hide()
	trap_2.hide()
	trap_3.hide()

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
	
	trap_2.show()
	trap_3.show()
	
	if body is CharacterBody2D:
		body.velocity.y = jump_speed
	
	var tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.tween_property(jump_block, "global_position:y", $"jump block end".global_position.y, 0.005)
	tween.tween_property(jump_block, "global_position:y", $"jump block start".global_position.y, 0.005)
