extends Area2D

@export var damage: int = 1

signal player_entered


func _on_body_entered(body):
	if body is Player2D and body.is_alive:
		body.take_damage(damage)
		player_entered.emit()
