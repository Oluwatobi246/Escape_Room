extends Node2D
@onready var trap_floor_1: AnimatableBody2D = $"trap floors/trap floor 1"
@onready var trap_floor_2: AnimatableBody2D = $"trap floors/trap floor 2"
@onready var trap_floor_3: AnimatableBody2D = $"trap floors/trap floor 3"
@onready var trap_floor_4: AnimatableBody2D = $"trap floors/trap floor4"

@onready var floor_3: StaticBody2D = $"floor 3"

@onready var trap_wall: AnimatableBody2D = $"trap wall"
@onready var trap_wall_sp: Marker2D = $"trap wall SP"

@onready var falling_group: Node2D = $"falling group"
@onready var fall_1: AnimatableBody2D = $"falling group/fall 1"
@onready var fall_2: AnimatableBody2D = $"falling group/fall 2"
@onready var fall_3: AnimatableBody2D = $"falling group/fall 3"
@onready var fall_sp: Marker2D = $"fall SP"

@onready var traps: Node2D = $traps

@onready var fall_2_stop: Marker2D = $"fall 2 stop"

@onready var stairs: Node2D = $stairs

var is_open: bool = false
var is_animating: bool = false

@onready var stair_5_trig: Area2D = $"player/stair 5 trig"
@onready var stair_5: AnimatableBody2D = $"stairs/stair 5"
@onready var stairs_5: Area2D = $"stairs/stair 5/stairs 5"

@onready var trap_point: Area2D = $trap

func _ready() -> void:
	trap_point.monitoring = false
	trap_point.hide()
	stairs_5.monitoring = false
	
	floor_3.visible = false
	floor_3.get_node("CollisionShape2D").set_deferred("disabled", true)
	
	$"floor 3 trig/CollisionShape2D".set_deferred("disabled", true)
	
	trap_wall.hide()
	$"trap wall trig".monitoring = false
	$"trap wall trig/CollisionShape2D".set_deferred("disabled", true)
	
	$"trap wall/death".set_deferred("monitoring", false)
	
	for fall in falling_group.get_children():
		if fall is AnimatableBody2D:
			fall.hide()
			fall.get_node("CollisionShape2D").set_deferred("disabled", true)
	
	$"stop trap".monitoring = false
	$"fall trig".monitoring = false
	$"remove trig".monitoring = false
		
	for trap in traps.get_children():
		if trap is Area2D:
			trap.hide()
			trap.monitoring = false
	
	for stair in stairs.get_children():
		stair.hide()
		stair.get_node("CollisionShape2D").set_deferred("disabled", true)
	
func _on_trap_floors_hide_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	$"trap floors hide/CollisionShape2D".set_deferred("disabled", true)
	for block in [trap_floor_1, trap_floor_2, trap_floor_3, trap_floor_4]:
		$"return sound".play()
		block.scale = Vector2(0,1)
		block.get_node("CollisionShape2D").set_deferred("disabled", true)
		
		
func reveal_block(block: AnimatableBody2D, is_tempurary: bool) -> void:
	if is_open:
		return
	
	block.get_node("CollisionShape2D").set_deferred("disabled", false)
	
	var tween = create_tween()
	tween.tween_property(block, "scale", Vector2(1,1), 0.2)\
	.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	await tween.finished
	
	if is_tempurary:
		await get_tree().create_timer(0.5, false).timeout
		await hide_block(block)
	
	else:
		is_animating = false
	
func hide_block(block: AnimatableBody2D) -> void:
	var close_block = create_tween()
	$"return sound".play()
	close_block.tween_property(block, "scale", Vector2(0,1), 0)\
	.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	
	await close_block.finished
	block.get_node("CollisionShape2D").set_deferred("disabled", true)
	is_animating = false

func _on_trap_floor_1_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if is_animating:
		return
	
	$"Node/trap floor 1 trig/CollisionShape2D".set_deferred("disabled", true)
	$"appear sound".play()
	await reveal_block(trap_floor_1, true)
	
	await get_tree().create_timer(1.6).timeout
	
	reveal_block(trap_floor_1, false)


func _on_trap_floor_2_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if is_animating:
		return
	
	$"Node/trap floor 2 trig/CollisionShape2D".set_deferred("disabled", true)
	$"appear sound".play()
	reveal_block(trap_floor_2, false)

func _on_trap_floor_3_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if is_animating:
		return
		
	$"Node/trap floor 3 trig/CollisionShape2D".set_deferred("disabled", true)
	$"appear sound".play()
	reveal_block(trap_floor_3, false)

func _on_trap_floor_4_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if is_animating:
		return
		
	$"Node/trap floor 4 trig/CollisionShape2D".set_deferred("disabled", true)
	$"appear sound".play()
	await reveal_block(trap_floor_4, true)
	
	await get_tree().create_timer(1.6).timeout
	
	reveal_block(trap_floor_4, false)

func _on_fake_floor_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	$"fake floor trig/CollisionShape2D".set_deferred("disabled", true)
	$"return sound".play()
	$"fake floor 1".hide()
	$"fake floor 1/CollisionShape2D".set_deferred("disabled", true)
	$"floor 3 trig/CollisionShape2D".set_deferred("disabled", false)

func _on_death_col_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if body.has_method("die"):
		body.die()

func _on_floor_3_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	for fall in falling_group.get_children():
		if fall is AnimatableBody2D:
			fall.show()
			fall.get_node("CollisionShape2D").set_deferred("disabled", false)
	
	$"stop trap".monitoring = true
	$"fall trig".monitoring = true
	$"remove trig".monitoring = true
	$"floor 3 trig/CollisionShape2D".set_deferred("disabled", true)
	floor_3.visible = true
	floor_3.get_node("CollisionShape2D").set_deferred("disabled", false)
	
	$"trap wall trig".monitoring = true
	$"trap wall trig/CollisionShape2D".set_deferred("disabled", false)
	
	
func _on_death_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if body.has_method("die"):
		body.die()

var wall_trap = Tween
func _on_trap_wall_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"trap wall/death".set_deferred("monitoring", true)
	trap_wall.show()
	$"trap wall trig/CollisionShape2D".set_deferred("disabled", true)
	
	wall_trap = create_tween()
	wall_trap.tween_property(trap_wall, "global_position:x", trap_wall_sp.global_position.x, 4.5)

var fall_tween = Tween
func _on_fall_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
		
	if is_animating:
		return
		
	$"fall trig/CollisionShape2D".set_deferred("disabled", true)
	
	fall_tween = create_tween().set_parallel(true)
	fall_tween.tween_property(fall_1, "global_position:y", fall_sp.global_position.y, 1.3)
	fall_tween.tween_property(fall_2, "global_position:y", fall_sp.global_position.y, 1.3)
	fall_tween.tween_property(fall_3, "global_position:y", fall_sp.global_position.y, 1.3)


func _on_stop_trap_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"stop trap/CollisionShape2D".set_deferred("disabled", true)
	
	if wall_trap and wall_trap.is_running():
		wall_trap.kill()
	
	if is_instance_valid(trap_wall):
		trap_wall.queue_free()

var move_tween = Tween
func _on_remove_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	for block in [trap_floor_1, trap_floor_2, trap_floor_3, trap_floor_4]:
		if block is AnimatableBody2D:
			block.hide()
			block.set_deferred("disabled", true)
			
	await fall_tween.finished
	
	for trap in traps.get_children():
		if trap is Area2D:
			trap.show()
			trap.monitoring = true
			
	var distance_x: float = fall_2_stop.global_position.x - fall_3.global_position.x
	move_tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS).set_parallel(true)
	move_tween.tween_property(fall_1, "global_position:x", distance_x, 3.0).as_relative()
	move_tween.tween_property(fall_2, "global_position:x", distance_x, 3.0).as_relative()
	move_tween.tween_property(fall_3, "global_position:x", distance_x, 3.0).as_relative()


func _on_fall_drop_1_body_entered(body: Node2D) -> void:
	if body == fall_3 or body.name == "fall 3":
		$"fall drop 1/CollisionShape2D".set_deferred("disabled", true)
		
		var drop_tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		drop_tween.tween_property(fall_1, "global_position:y", $Marker2D.global_position.y, 0.5)
		
		await drop_tween.finished
		fall_1.queue_free()

func _on_fall_drop_2_body_entered(body: Node2D) -> void:
	if body == fall_3 or body.name == "fall 3":
		$"fall drop 2/CollisionShape2D".set_deferred("disabled", true)
		
		var drop_tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		drop_tween.tween_property(fall_2, "global_position:y", $Marker2D.global_position.y, 0.5)
		
		await drop_tween.finished
		fall_2.queue_free()

func _on_reveal_stairs_body_entered(body: Node2D) -> void:
	if body == fall_3 or body.name == "fall 3":
		$"reveal stairs/CollisionShape2D".set_deferred("disabled", true)
		
		stairs_5.monitoring = true
		
		for stair in stairs.get_children():
			stair.show()
			stair.get_node("CollisionShape2D").set_deferred("disabled", false)

		var tween = create_tween()
		tween.tween_property(fall_3, "global_position:y", $"fall 2 stop".global_position.y, 0.5)
		
		await tween.finished
		if is_instance_valid(fall_3):
			fall_3.queue_free()

func _on_stairs_5_area_entered(area: Area2D) -> void:
	if area == stair_5_trig or area.name == "stair 5 trig":
		$"stairs/stair 5/stairs 5/CollisionShape2D".set_deferred("disabled", true)
		
		var tween = create_tween()
		tween.tween_property(stair_5, "global_position:y", $"stair 5 SP".global_position.y, 1.0)

func _on_trap_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	trap_point.monitoring = true
	trap_point.show()
