extends Control
class_name HudManager


@export var player: Player2D
@export var health_label: Label
@export var lives_label: Label


func _ready() -> void:
	visible = true
	

func update() -> void:
	health_label.text = str(player.health)
	lives_label.text = "x" + str(player.lives)
	
