extends Area2D


@export var anim_player: AnimatedSprite2D
signal checkpoint_updated(checkpoint)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_player.play("idle")


func _on_body_entered(body: Node2D) -> void:
	if body is Player2D:
		checkpoint_updated.emit(self)
