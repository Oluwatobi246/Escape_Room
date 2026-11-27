extends Node2D

@onready var player: CharacterBody2D = $player
@onready var bouncers: Node2D = $BOUNCERS


var tap_hop_active: bool = false
var hop_direction: float = 1.0
var hop_forward_speed: float = 300.0 # How far forward each jump tap pushes the player
var hop_drag: float = 450.0          # How quickly forward speed stops so the player falls straight down

var can_bounce: bool = true
var wall_bounce_speed: float = 220.0 # Horizontal push away from the wall on bounce

@onready var sounds: AudioStreamPlayer2D = $sounds


var bounce_1_hit: int = 0 
var bounce_2_hit: int = 0 
var bounce_3_hit: int = 0 
var bounce_4_hit: int = 0 
var bounce_5_hit: int = 0 

func die() -> void:
	if player.has_method("die"):
		player.die()
		
func _physics_process(delta: float) -> void:
	if not tap_hop_active:
		return
	
	if not player.is_on_floor():
		if player.velocity.y > 0:
			player.velocity.y += player.gravity * player.fall_gravity_multiplier * delta
		
		else:
			player.velocity.y += player.gravity * delta
	
	player.sprite.flip_h = (hop_direction < 0)
	
	if Input.is_action_just_pressed("ui_accept"):
		player.velocity.y = player.JUMP_VELOCITY
		player.velocity.x = hop_direction * hop_forward_speed
		player.jump_sfx.play()
	
	else:
		player.velocity.x = move_toward(player.velocity.x, 0.0, hop_drag * delta)
	
	if not player.is_on_floor():
		if player.velocity.y < 0:
			player.sprite.play("jump")
		else:
			player.sprite.play("fall")
	else:
		player.sprite.play("idle")

	# 5. Apply the movement to the player
	player.move_and_slide()
			
func _ready() -> void:
	$door.set_deferred("monitoring", false)
	$door.hide()
	
	for bounce in bouncers.get_children():
		bounce.hide()
		bounce.get_node("CollisionShape2D").set_deferred("disabled", true)
		bounce.get_node("ColorRect2").hide()
		for child in bounce.get_children():
			if child is Area2D:
				child.set_deferred("monitoring", false)
		

	
func _on_death_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if body.has_method("die"):
		body.die()

func _on_wall_1_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if body.has_method("die"):
		body.die()

func _on_wall_2_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if body.has_method("die"):
		body.die()

func _on_floor_1_hide_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if tap_hop_active:
		return
	
	tap_hop_active = true
	
	# keep whatever direction the player was already facing when entering the trigger
	if player.sprite.flip_h:
		hop_direction = -1.0
	
	else:
		hop_direction = 1.0
	
	player.run_sfx.stop()
	player.set_physics_process(false)
	
	$"FLOORS/floor 1".get_node("CollisionShape2D").set_deferred("disabled", true)
	$"FLOORS/floor 1".hide()
	
	for bounce in bouncers.get_children():
		bounce.show()
		bounce.get_node("CollisionShape2D").set_deferred("disabled", false)
		if bounce.name == "Bounce 1":
			$"BOUNCERS/Bounce 1/ColorRect2".show()
			for child in bounce.get_children():
				if child is Area2D:
					child.set_deferred("monitoring", true)
		
		else:
			bounce.get_node("ColorRect2").hide()
		

func bounce_player(current_bounce: StaticBody2D,next_bounce: StaticBody2D, extra_off_bounce: StaticBody2D) -> void:
	if not tap_hop_active or not can_bounce:
		return
	
	can_bounce = false
	
	hop_direction = -hop_direction
	
	player.sprite.flip_h = (hop_direction < 0)
	
	player.velocity.x = hop_direction * wall_bounce_speed
	player.velocity.y = player.JUMP_VELOCITY
	
	current_bounce.get_node("ColorRect2").hide()
	for child in current_bounce.get_children():
		if child is Area2D:
			child.set_deferred("monitoring", false)
	
	if extra_off_bounce != null:
		extra_off_bounce.get_node("ColorRect2").hide()
		for child in extra_off_bounce.get_children():
			if child is Area2D:
				child.set_deferred("monitoring", false)
				
	if next_bounce != null:
		next_bounce.get_node("ColorRect2").show()
		for child in next_bounce.get_children():
			if child is Area2D:
				child.set_deferred("monitoring", true)
						
	# 5. Wait 0.2 seconds so the player clears the wall, then unlock for future bounces
	await get_tree().create_timer(0.2, false).timeout
	can_bounce = true
	
	
func _on_bounce_1_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	bounce_1_hit += 1
	
	if bounce_1_hit == 1:
		bounce_player($"BOUNCERS/Bounce 1",$"BOUNCERS/Bounce 5", null)
		sounds.play()
		
	elif bounce_1_hit == 2:
		if BS_1_open_count == 1:
			bounce_player($"BOUNCERS/Bounce 1", $"BOUNCERS/Bounce 4", null)
			sounds.play()
		
		else:
			bounce_player($"BOUNCERS/Bounce 1", null, null)
			die()
			return
	
	elif bounce_1_hit == 3:
		bounce_player($"BOUNCERS/Bounce 1", null, null)
		sounds.play()
		$door.show()
		$door.set_deferred("monitoring", true)

func _on_bounce_5_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	bounce_5_hit += 1
	
	if bounce_5_hit == 1:
		bounce_player($"BOUNCERS/Bounce 5", $"BOUNCERS/Bounce 3", null)
		sounds.play()
		$"TRIGGERS/bounce 2_1 open/CollisionShape2D".set_deferred("disabled", false)
	
	if bounce_5_hit == 2:
		bounce_player($"BOUNCERS/Bounce 5", $"BOUNCERS/Bounce 1", $"BOUNCERS/Bounce 4")
		sounds.play()
		bounce_4_hit += 1
		$"TRIGGERS/BS 1 right open/CollisionShape2D".set_deferred("disabled", false)
	
	if bounce_5_hit == 3:
		if BS_1_open_count == 3:
			bounce_player($"BOUNCERS/Bounce 5", null, null)
			die()
		else:
			$"TRIGGERS/BS 4 right/CollisionShape2D".set_deferred("disabled", true)
			bounce_player($"BOUNCERS/Bounce 5", $"BOUNCERS/Bounce 1", null)
			sounds.play()
			$"TRIGGERS/BS 1 right".hide()
			$"TRIGGERS/BS 1 right".set_deferred("monitoring", false)
			

func _on_bounce_3_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	bounce_3_hit += 1
	
	if bounce_3_hit == 1:
		bounce_player($"BOUNCERS/Bounce 3", null, null)
		die()
		return
	
	elif bounce_3_hit == 2:
		bounce_player($"BOUNCERS/Bounce 3", $"BOUNCERS/Bounce 4", $"BOUNCERS/Bounce 2")
		sounds.play()
		$"TRIGGERS/BS 4 right/CollisionShape2D".set_deferred("disabled", false)

func _on_bounce_2_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	bounce_2_hit += 1
	
	if bounce_2_hit == 1:
		bounce_player($"BOUNCERS/Bounce 2", $"BOUNCERS/Bounce 4", $"BOUNCERS/Bounce 3")
		sounds.play()
		bounce_3_hit += 1
		$"TRIGGERS/BS 5_1 open/CollisionShape2D".set_deferred("disabled", false)
	
	if bounce_2_hit == 2:
		$"TRIGGERS/BS 1 right".show()
		$"TRIGGERS/BS 1 right".set_deferred("monitoring", true)

		bounce_player($"BOUNCERS/Bounce 2", $"BOUNCERS/Bounce 5", null)
		sounds.play()
		
var bounce_4_safe: bool = false
func _on_bounce_4_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	bounce_4_hit += 1
	
	if bounce_4_hit == 1:
		if bounce_4_safe == false:
			bounce_player($"BOUNCERS/Bounce 4", null, null)
			die()
			
	elif bounce_4_hit == 2:
		$"TRIGGERS/BS 3 move/CollisionShape2D".set_deferred("disabled", false)
		bounce_player($"BOUNCERS/Bounce 4", $"BOUNCERS/Bounce 2", null)
		sounds.play()
		
	elif bounce_4_hit == 3:
		if BS_1_open_count == 2:
			bounce_player($"BOUNCERS/Bounce 4", $"BOUNCERS/Bounce 2", null)
			sounds.play()
			$"TRIGGERS/BS 4 right/CollisionShape2D".set_deferred("disabled", true)
		else:
			bounce_player($"BOUNCERS/Bounce 4", null, null)
			die()
	
func _on_bounce_2_1_open_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
		
	$"TRIGGERS/bounce 2_1 open/CollisionShape2D".set_deferred("disabled", true)
	for bounce_2 in bouncers.get_node("Bounce 2").get_children():
		if bounce_2.name == "ColorRect2":
			bounce_2.show()
		
		if bounce_2 is Area2D:
			bounce_2.set_deferred("monitoring", true)


func _on_bs_5_1_open_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"TRIGGERS/BS 5_1 open/CollisionShape2D".set_deferred("disabled", true)
	for bounce_5 in bouncers.get_node("Bounce 5").get_children():
		if bounce_5.name == "ColorRect2":
			bounce_5.show()
		
		if bounce_5 is Area2D:
			bounce_5.set_deferred("monitoring", true)

func _on_bs_1_right_open_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
		
	$"TRIGGERS/BS 1 right open/CollisionShape2D".set_deferred("disabled", true)
	$"TRIGGERS/BS 1 right".show()
	$"TRIGGERS/BS 1 right".set_deferred("monitoring", true)


var BS_1_open_check: bool = false
var BS_1_open_count: int = 0
func _on_bs_1_right_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if BS_1_open_check:
		return
	
	BS_1_open_count += 1
	
	if BS_1_open_count == 1:
		$"TRIGGERS/BS 1 right".hide()
		$"TRIGGERS/BS 1 right".set_deferred("monitoring", false)
	

	if BS_1_open_count == 2:
		$"TRIGGERS/BS 1 right".hide()
		$"TRIGGERS/BS 1 right".set_deferred("monitoring", false)

	if BS_1_open_count == 3:
		$"TRIGGERS/BS 1 right".hide()
		$"TRIGGERS/BS 1 right".set_deferred("monitoring", false)
	
	
func _on_bs_3_move_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	$"TRIGGERS/BS 3 move/CollisionShape2D".set_deferred("disabled", true)
	for bounce_3 in bouncers.get_node("Bounce 3").get_children():
		if bounce_3.name == "ColorRect2":
			bounce_3.show()
		
		if bounce_3 is Area2D:
			bounce_3.set_deferred("monitoring", true)
	
	var get_block_x = $"BOUNCERS/Bounce 2".global_position.x
	
	var tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.tween_property($"BOUNCERS/Bounce 2", "global_position:x", $"MARKERS/bounce 2 SP".global_position.x, 0.56)
	await tween.finished
	
	await get_tree().create_timer(1.0).timeout
	
	var return_tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	return_tween.tween_property($"BOUNCERS/Bounce 2", "global_position:x", get_block_x, 1.0)
	
	
var BS_4_open_check: bool = false
func _on_bs_4_right_body_entered(body: Node2D) -> void:
	if not (body.name == "player" or body.is_in_group("player")):
		return
	
	if BS_4_open_check:
		return
		
	$"TRIGGERS/BS 1 right".show()
	$"TRIGGERS/BS 1 right".set_deferred("monitoring", true)
	
	BS_4_open_check = true
