extends CanvasLayer
"""
@onready var game_over_menu: PanelContainer = $"../Game Over"
@onready var game_over_sfx: AudioStreamPlayer2D = $"../Game Over/GameOverSFX"

@onready var heart_1: TextureRect = $"HeartsContainer/Heart 1"
@onready var heart_2: TextureRect = $"HeartsContainer/Heart 2"
@onready var heart_3: TextureRect = $"HeartsContainer/Heart 3"
@onready var heart_4: TextureRect = $"HeartsContainer/Heart 4"

func _ready() -> void:
	update_hearts(GameManager.current_hearts)
	GameManager.game_over_triggered.connect(show_game_over)

func update_hearts(current_lives: int) -> void:
	heart_1.visible = current_lives >= 1
	heart_2.visible = current_lives >= 2
	heart_3.visible = current_lives >= 3
	heart_4.visible = current_lives >= 4

func show_game_over() -> void:
	update_hearts(0)
	game_over_sfx.play()
	game_over_menu.show()
"""
