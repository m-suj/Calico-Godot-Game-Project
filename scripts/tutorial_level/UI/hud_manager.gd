class_name HudManager extends Control


@export var player: Player2D
@export var health_label: Label
@export var lives_label: Label


func _ready() -> void:
	visible = true
	

# Public method called by LevelManager, when player's stat changes
func update() -> void:
	health_label.text = str(player.health)
	lives_label.text = "x" + str(player.lives)
	
