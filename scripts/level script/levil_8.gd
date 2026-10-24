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
	tween.tween_property($"trap show/trap5", "global_position:x", $"trap 4 SP".global_position.x, 0.5)
