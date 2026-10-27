extends Node2D

@onready var player: CharacterBody2D = $player

@onready var trap_hide: Node2D = $"trap hide"

@onready var trap_show: Node2D = $"trap show"

var touch_count = 0
var can_count: bool = false

func _ready() -> void:
	print(touch_count  )
	if player:
		# higher/faster jump
		player.JUMP_VELOCITY = -2000
		
		#floaty fall
		player.fall_gravity_multiplier = 1.0
		
	$"trap hide/up trap3".hide()
	$"trap hide/up trap4".hide()
	$"trap show/trap4".hide()
	$"trap hide/up trap8".hide()
	$"trap show/trap8".hide()
	$"trap show/trap9".hide()
	$"trap show/trap12".hide()
	
	$"count trig".monitoring = false
	$"count trig".get_node("CollisionShape2D").set_deferred("disabled", true)
	
	$"bring back count trig2".monitoring = false
	$"bring back count trig2".get_node("CollisionShape2D").set_deferred("disabled", true)
	
	$"trap hide/up trap9".hide()
	
	$"up trap 9 trig".set_deferred("monitoring", false)
	$"up trap 9 trig/CollisionShape2D".set_deferred("disabled", true)
	
	$"up trap 7 trig/CollisionShape2D".set_deferred("disabled", true)
	
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
	
	$"up trap 7 trig/CollisionShape2D".set_deferred("disabled", false)
	
var trap_loop = Tween
func _on_up_trap_7_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"up trap 7 trig/CollisionShape2D".set_deferred("disabled", true)
	trap_loop= create_tween().set_loops().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	
	trap_loop.tween_property($"trap hide/up trap7", "global_position", $"up trap 7 SP stop".global_position, 0.25)\
	.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	trap_loop.tween_property($"trap hide/up trap7", "global_position", $"up trap 7 SP start".global_position, 0.25)\
	.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)


func _on_up_trap_7_stop_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"up trap 7 stop/CollisionShape2D".set_deferred("disabled", true)
	if trap_loop and trap_loop.is_running():
		trap_loop.kill()
	
	var tween = create_tween()
	tween.tween_property($"trap hide/up trap7", "global_position", $"up trap 7 mid".global_position, 0.5)
	
	$"trap hide/up trap8".show()
	$"count trig".get_node("CollisionShape2D").set_deferred("disabled", false)
	$"count trig".monitoring = true

func _on_fake_traps_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"trap show/trap8".show()
	$"trap show/trap9".show()

func _on_count_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"count trig/CollisionShape2D".set_deferred("disabled", true)
	$"bring back count trig2".monitoring = true
	$"bring back count trig2".get_node("CollisionShape2D").set_deferred("disabled", false)
	
	if can_count:
		return
		
	can_count = true
	
	touch_count += 1
	print(touch_count)
	
	if touch_count >= 2:
		$"count trig".set_deferred("monitoring",false)
		$"count trig/CollisionShape2D".set_deferred("disabled",true)		
		
		$"fake traps".set_deferred("monitoring",false)
		$"fake traps/CollisionShape2D".set_deferred("disabled",true)
		
		$"trap show/trap8".get_node("CollisionShape2D").set_deferred("disabled", true)
		$"trap show/trap9".get_node("CollisionShape2D").set_deferred("disabled", true)
		
		$"bring back count trig2".set_deferred("monitoring",false)
		$"bring back count trig2".get_node("CollisionShape2D").set_deferred("disabled", true)

func _on_bring_back_count_trig_2_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	can_count = false
	$"bring back count trig2".set_deferred("monitoring",false)
	$"bring back count trig2".get_node("CollisionShape2D").set_deferred("disabled", true)
	$"count trig/CollisionShape2D".set_deferred("disabled", false)
	
func _on_up_trap_9_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"up trap 9 trig/CollisionShape2D".set_deferred("disabled", true)
	$"trap hide/up trap9".show()
	
	var tween = create_tween()
	tween.tween_property($"trap hide/up trap10", "global_position:x", $"up trap 10 sp".global_position.x, 0.05)
	
func _on_trig_up_trap_9_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"trig up trap 9/CollisionShape2D".set_deferred("disabled", true)
	
	$"up trap 9 trig".set_deferred("monitoring", true)
	$"up trap 9 trig/CollisionShape2D".set_deferred("disabled", false)
