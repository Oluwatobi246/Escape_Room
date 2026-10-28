extends Node2D

@onready var push_up: AnimatableBody2D = $"floor 3/push up"

var is_bouncing: bool = false
var launch_force: flaot = -650.0
