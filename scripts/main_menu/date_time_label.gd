extends Label


@onready var datetime = Time.get_datetime_dict_from_system()
@onready var timer: Timer = $Timer
var minute_bf: int


func _ready() -> void:
	_update_body_text()


func _on_timer_timeout() -> void:
	datetime = Time.get_datetime_dict_from_system()
	if minute_bf != datetime["minute"]:
		_update_body_text()


func _update_body_text() -> void:
	minute_bf = datetime["minute"]
	var formatted_time = "%02d:%02d" % [datetime.hour, datetime.minute]
	var formatted_date = "%02d.%02d.%04d" % [datetime.day, datetime.month, datetime.year]
	text = formatted_time + '\n' + formatted_date
