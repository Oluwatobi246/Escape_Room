extends Node2D

@onready var player: CharacterBody2D = $player
@onready var traps: Node = $traps
@onready var next_floor: Node2D = $"Next Floor"




func _ready() -> void:
	for trigger in $triggers.get_children().slice(0,9):
		trigger.hide()
		trigger.set_deferred("monitoring", false)
	
	for trap in $traps.get_children():
		trap.hide()
		trap.set_deferred("monitoring", false)
	
	$"triggers/Next Floor".set_deferred("monitoring", true)
	
	$traps/trap.hide()
	$traps/trap.set_deferred("monitoring", false)

	$"triggers/blind 2".set_deferred("monitoring", false)
	
	$traps/trap2.hide()
	$traps/trap2.set_deferred("monitoring", false)
	
	$traps/trap3.hide()
	$traps/trap3.set_deferred("monitoring", false)
	
	$"triggers/new floor 3".set_deferred("monitoring", false)
	
	for n_f in next_floor.get_children():
		n_f.hide()
		n_f.get_node("CollisionShape2D").set_deferred("disabled", true)
	
	$"Next Floor/floor 1".show()
	$"Next Floor/floor 1".get_node("CollisionShape2D").set_deferred("disabled", false)


func _on_blind_1_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/blind 1/CollisionShape2D".set_deferred("disabled", true)
	
	player.hide()

func _on_floor_1_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/floor 1/CollisionShape2D".set_deferred("disabled", true)
	player.show()
	
	var floor_2 = $"floor/floor 2".global_position.x
	var tween = create_tween()
	tween.tween_property($"floor/floor 2", "global_position:x", $"markers/floor 2".global_position.x, 0.3)
	
	await tween.finished
	await get_tree().create_timer(1.5).timeout
	
	var return_tween = create_tween()
	return_tween.tween_property($"floor/floor 2", "global_position:x", floor_2, 0.5)
	
	await return_tween.finished
	
	$"triggers/trap 1 trig".set_deferred("monitoring", false)
	$"triggers/blind 2".set_deferred("monitoring", true)

func _on_death_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if body.has_method("die"):
		body.die()


func _on_trap_1_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/trap 1 trig/CollisionShape2D".set_deferred("disabled", true)
	
	$traps/trap.show()
	$traps/trap.set_deferred("monitoring", true)


func _on_blind_2_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/blind 2/CollisionShape2D".set_deferred("disabled", true)
	
	player.hide()


func _on_blind_3_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/blind 3/CollisionShape2D".set_deferred("disabled", true)
	
	player.show()
	
	var floor_4 = $"floor/floor 4".global_position.x
	var tween = create_tween()
	tween.tween_property($"floor/floor 4", "global_position:x",$"markers/floor 4".global_position.x, 0.2)
	
	await tween.finished
	await get_tree().create_timer(1.5, false).timeout
	
	var return_tween = create_tween()
	return_tween.tween_property($"floor/floor 4", "global_position:x", floor_4, 0.2)
	
	$traps/trap2.show()
	$traps/trap2.set_deferred("monitoring", true)
	
func _on_blind_4_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/blind 4/CollisionShape2D".set_deferred("disabled", true)
	player.show()


func _on_trap_3_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/trap 3 trig/CollisionShape2D".set_deferred("disabled", true)
	
	$traps/trap3.show()
	$traps/trap3.set_deferred("monitoring", true)


func _on_next_floor_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	player.hide()
	$"side collision/col/CollisionShape2D".set_deferred("disabled", false)
	$"triggers/new floor 3".set_deferred("monitoring", true)
	$"triggers/Next Floor/CollisionShape2D".set_deferred("disabled", true)
	
	$floor.queue_free()
	for trap in traps.get_children().slice(0,3):
		trap.hide()
		trap.set_deferred("monitoring", false)
	
	for n_f in next_floor.get_children():
		n_f.show()
		n_f.get_node("CollisionShape2D").set_deferred("disabled", false)
	
	for trigger in $triggers.get_children().slice(0,9):
		trigger.hide()


func _on_blind_5_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/blind 5/CollisionShape2D".set_deferred("disabled", true)
	
	player.hide()


func _on_new_floor_3_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers/new floor 3/CollisionShape2D".set_deferred("disabled", true)
	player.show()
	var new_floor_3 = $"Next Floor/floor 3".global_position.x

	var tween = create_tween()
	tween.tween_property($"Next Floor/floor 3", "global_position:x", $"markers/New floor 3".global_position.x, 0.2)
	
	await tween.finished
	
	await get_tree().create_timer(1.5, false).timeout
	
	var return_tween = create_tween()
	return_tween.tween_property($"Next Floor/floor 3", "global_position:x", new_floor_3, 0.2)
	
	await return_tween.finished
	
	$"side collision/col/CollisionShape2D".set_deferred("disabled", true)
	
	
func _on_death_2_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if body.has_method("die"):
		body.die()

func _on_death_3_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if body.has_method("die"):
		body.die()

func _on_death_4_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if body.has_method("die"):
		body.die()


func _on_blind_6_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers 2/blind 6".set_deferred("disabled", true)
	
	player.hide()


func _on_trap_4_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers 2/trap 4 trig/CollisionShape2D".set_deferred("disabled", true)
	
	player.show()
	
	$traps/trap4.show()


func _on_trap_5_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers 2/trap 5 trig/CollisionShape2D".set_deferred("disabled", true)
	
	player.hide()
	$traps/trap5.show()


func _on_trap_6_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers 2/trap 6 trig/CollisionShape2D".set_deferred("disabled", true)
	
	player.show()
	$traps/trap6.show()


func _on_trap_7_trig_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"triggers 2/trap 7 trig/CollisionShape2D".set_deferred("disabled", true)
	
	player.hide()
	$traps/trap7.show()
	
