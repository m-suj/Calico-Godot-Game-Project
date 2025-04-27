extends AnimatableBody2D


@onready var area_2d: Area2D = $Area2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_body_entered(body: Node2D) -> void:
	if body is Player2D:
		animation_player.play("move3_vertical")
