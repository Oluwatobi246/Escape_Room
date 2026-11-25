extends Node2D

@onready var player: CharacterBody2D = $player
@onready var bouncers: Node2D = $BOUNCERS


var tap_hop_active: bool = false
var hop_direction: float = 1.0
var hop_forward_speed: float = 300.0 # How far forward each jump tap pushes the player
var hop_drag: float = 450.0          # How quickly forward speed stops so the player falls straight down

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
		if bounce is Area2D:
			bounce.get_node("Area2D").set_deferred("monitoring", false)
		

func reverse_position(Area_block: Area2D) -> void:
	if player.sprite.flip_h:
		hop_direction = -1.0
	
	else:
		hop_direction = 1.0


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
		bounce.get_node("ColorRect2").hide()
		if bounce is Area2D:
			bounce.get_node("Area2D").set_deferred("monitoring", false)
	

func _on_bounce_1_body_entered(body: Node2D) -> void:
	pass
