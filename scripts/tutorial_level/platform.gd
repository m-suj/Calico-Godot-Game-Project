extends StaticBody2D


@export var x: int = 400
@export var y: int = 40

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CollisionShape2D.shape.size = Vector2(x, y)
	
	$ColorRect.position += Vector2(($ColorRect.size.x - x) / 2, ($ColorRect.size.y - y) / 2)
	$ColorRect.size = Vector2(x, y)
