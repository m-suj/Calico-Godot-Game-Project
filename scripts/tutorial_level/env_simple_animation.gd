extends TileMapLayer


@export var interval: float = 0.5
@export var width: int
@export var keyframes: int = 2

var counter: int = 0

@onready var timer: Timer = Timer.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if interval <= 1.0 / 60.0:
		interval = 0.5
	if width <= 0:
		width = 608
	if keyframes <= 1:
		keyframes = 2
	timer.wait_time = interval
	timer.one_shot = false
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	
	add_child(timer)


func _on_timer_timeout() -> void:
	if counter < keyframes:
		counter += 1
		position -= Vector2(152, 0)
		# position -= Vector2(width / keyframes, 0)
	else:
		counter = 1
		position += Vector2(456, 0)
		# position += Vector2(width * (keyframes - 1) / keyframes, 0)