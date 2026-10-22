extends Node2D

@onready var trap_floor_1: AnimatableBody2D = $"trap floor 1"
@onready var trap_floor_1_sp: Marker2D = $"trap floor 1 SP"
@onready var trap_floor_1_x: float = $"trap floor 1".position.x

@onready var floor_wall_1: AnimatableBody2D = $"floor wall 1"
@onready var floor_wall_1_sp: Marker2D = $"floor wall 1 SP"

@onready var floor_wall_2: AnimatableBody2D = $"floor wall 2"
@onready var floor_wall_2_sp: Marker2D = $"floor wall 2 SP"
@onready var floor_wall_2_y: float = $"floor wall 2".position.y

@onready var fake_floor: AnimatableBody2D = $"fake floor"
@onready var fake_floor_sp: Marker2D = $"fake floor SP"
@onready var fake_floor_y: float = $"fake floor".position.y

@onready var trap: AnimatableBody2D = $trap
@onready var trap_sp: Marker2D = $"trap SP"

@onready var key_1: Area2D = $"Key button/key 1"
@onready var key_2: Area2D = $"Key button/key 2"
@onready var key_3: Area2D = $"Key button/key 3"

@onready var spike_trig: Area2D = $"player/spike trig"

var player_sequence: Array = []

func _ready() -> void:
	
	trap.hide()
	trap.get_node("CollisionShape2D").set_deferred("disabled", true)
	
	# if no code are generated before as for first time entering the game
	if GameManager.level_7_sequence.is_empty():
		generate_level_code()

func generate_level_code() -> void:
	var key_pool = [1, 2, 3]
	key_pool.shuffle()
	
	GameManager.level_7_sequence = [key_pool[0], key_pool[1]]
	
	# Debug print in console to verify the code
	print("Level 7 Gate Code: ", GameManager.level_7_sequence)
	
func _on_trap_floor_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"trap floor trig/CollisionShape2D".set_deferred("disabled", true)
	
	var tween = create_tween()
	$"trap floor 1/shoot out".play()
	tween.tween_property(trap_floor_1, "global_position:x", trap_floor_1_sp.global_position.x, 0.2)
	
	await get_tree().create_timer(1.0, false).timeout
	
	var return_tween = create_tween()
	return_tween.tween_property(trap_floor_1, "global_position:x", trap_floor_1_x, 0.2)
	$"trap floor 1/shoot in".play()

func _on_death_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if body.has_method("die"):
		body.die()

func _on_floor_wall_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return

	var tween = create_tween().set_parallel(true)
	$"floor wall 2/gate close".play()
	tween.tween_property(floor_wall_1, "global_position:y", floor_wall_1_sp.global_position.y, 0.2)
	tween.tween_property(floor_wall_2, "global_position:y", floor_wall_2_sp.global_position.y, 0.2)

func open_gate_2() -> void:
	var tween = create_tween()
	tween.tween_property(floor_wall_2, "global_position:y", floor_wall_2_y, 0.5)\
  	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
func trigger_trap() -> void:
	trap.show()
	$"trap/death trap".monitoring = true
	
	trap.get_node("CollisionShape2D").set_deferred("disabled", false)
	
	var tween = create_tween()
	tween.tween_property(trap, "global_position:x", trap_sp.global_position.x, 0.2)
	
func _on_death_2_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if body.has_method("die"):
		body.die()

func _on_fake_floor_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
		
	$"fake floor trig/CollisionShape2D".set_deferred("disabled",true)
	var tween = create_tween()
	tween.tween_property(fake_floor, "global_position:y", fake_floor_sp.global_position.y, 0.2)

	await get_tree().create_timer(1.5, false).timeout

	var return_tween = create_tween()
	return_tween.tween_property(fake_floor, "global_position:y", fake_floor_y, 0.2)


func _on_key_1_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
		
	key_1.hide()
	key_1.get_node("CollisionShape2D").set_deferred("disabled", true)
	register_key_touch(1)

func _on_key_2_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	key_2.hide()
	key_2.get_node("CollisionShape2D").set_deferred("disabled", true)
	register_key_touch(2)

func _on_key_3_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	key_3.hide()
	key_3.get_node("CollisionShape2D").set_deferred("disabled", true)
	register_key_touch(3)

# this is the sequence check
func register_key_touch(key_num: int) -> void:
	player_sequence.append(key_num)
	
	# Only evaluate when player has collected 2 keys	
	if player_sequence.size() == 2:
		if player_sequence == GameManager.level_7_sequence:
			open_gate_2()
			$"Key button".hide()
			$"Key button".get_node("key 1/CollisionShape2D").set_deferred("disabled", true)
		
		else:
			trigger_trap()

func _on_death_trap_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if body.has_method("die"):
		body.die()
