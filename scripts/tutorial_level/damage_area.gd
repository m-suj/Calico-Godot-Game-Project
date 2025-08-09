extends Area2D

@export var damage: int = 1
var touches_player: bool = false
var player_body: Player2D

signal player_entered


func _on_body_entered(body):
	if body is Player2D:
		player_body = body
		touches_player = true
#		player_entered.emit()


func _on_body_exited(body):
	if body is Player2D:
		player_body = null
		touches_player = false

		
func _physics_process(delta: float) -> void:
	if touches_player and player_body.is_alive and not player_body.has_iframes:
		player_body.take_damage(damage)
		