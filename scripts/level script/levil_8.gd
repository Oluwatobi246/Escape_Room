extends Node2D

@onready var player: CharacterBody2D = $player

func _ready() -> void:
	if player:
		# higher/faster jump
		player.JUMP_VELOCITY = -2000
		
		#floaty fall
		player.fall_gravity_multiplier = 1.0
