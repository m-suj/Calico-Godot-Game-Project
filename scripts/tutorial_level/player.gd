extends CharacterBody2D
class_name Player2D


@export var enemies: Node

const SPEED: float           = 60.0
const JUMP_VELOCITY: float   = -350.0
const BOUNCE_VELOCITY: float = -400.0
const GRAVITY: Vector2       = Vector2(0, 980)

var jump_buffer: bool = false

signal health_changed(new_health)
signal lives_changed()
@export var max_health: int = 3
var health: int = 3
var lives: int = 3

var is_alive: bool = true
var has_iframes: bool = false
@onready var hitbox: CollisionShape2D = $"CollisionShape2D"
@onready var iframe_timer: Timer = $"Iframe Timer"

@onready var bounce_raycasts: Node2D = $BounceRaycasts
@onready var sprite_player: AnimatedSprite2D = $AnimatedSprite2D


func take_damage(damage: int):
	health -= damage
	print("I took damage, I have now {} health and {} lives".format([health, lives], "{}"))
	health_changed.emit(health)
	hitbox.disabled = true
	iframe_timer.start()
	if health <= 0:
		lose_life()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += GRAVITY * delta
		if not Input.is_action_pressed("jump") and velocity.y < 0:
			velocity += GRAVITY * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		else:
			jump_buffer = true

	if Input.is_action_just_released("jump"):
		jump_buffer = false

	if is_on_floor() and jump_buffer:
		velocity.y = JUMP_VELOCITY
		jump_buffer = false


	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	if direction == 0:
		sprite_player.play("idle")
	else:
		sprite_player.play("running")
		sprite_player.flip_h = direction < 0
		# Apply acceleration
		velocity.x += direction * SPEED

	# Apply friction/resistance/whatever
	velocity.x *= 0.75
	velocity.y *= 0.99

	_check_bounce(delta)
	move_and_slide()
	apply_floor_snap()
	

func _check_bounce(delta):
	if velocity.y > 0:
		for raycast in bounce_raycasts.get_children():
			raycast.target_position = Vector2.DOWN * velocity * delta + Vector2.DOWN
			raycast.force_raycast_update()
			if raycast.is_colliding() and raycast.get_collision_normal() == Vector2.UP:
				velocity.y = (raycast.get_collision_point() - raycast.global_position - Vector2.DOWN).y / delta
				raycast.get_collider().entity.call_deferred("be_bounced_upon", self)
				break


func bounce(bounce_velocity = BOUNCE_VELOCITY):
	velocity.y = bounce_velocity


func lose_life():
	lives -= 1
	lives_changed.emit()
	health = max_health
	if lives <= 0:
		print("I died")
	is_alive = false
	print('I lost 1 life')
	$AnimatedSprite2D.rotate(deg_to_rad(-90))
	

func on_fell():
	lose_life()

func on_respawn():
	is_alive = true
	print('I respawned')
	$AnimatedSprite2D.rotate(deg_to_rad(90))


func _on_iframe_end() -> void:
	hitbox.disabled = false
