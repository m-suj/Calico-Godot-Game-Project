extends Area2D

@onready var timer = $Timer

signal player_fell

func _on_body_entered(body):
	if body is Player2D:
		body.on_fell()
		player_fell.emit()


func _on_timer_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
