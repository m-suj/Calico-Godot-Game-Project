extends Node2D


func be_bounced_upon(bouncer):
	if bouncer.has_method("bounce"):
		bouncer.bounce()


func _physics_process(delta: float) -> void:
	pass
