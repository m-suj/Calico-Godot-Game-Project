extends Control
class_name HudManager


@export var player: Player2D
@export var health_label: Label
@export var lives_label: Label


func _ready() -> void:
	visible = true
# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	health_label.text = str(player.health)
#	lives_label.text = "x" + str(player.lives)
	
func update() -> void:
	health_label.text = str(player.health)
	lives_label.text = "x" + str(player.lives)
	

#func _on_player_health_changed(new_health: int) -> void:
#	health_label.text = str(new_health)
#
#
#func _on_player_lives_changed(new_lives: int) -> void:
#	lives_label.text = "x" + str(new_lives)
