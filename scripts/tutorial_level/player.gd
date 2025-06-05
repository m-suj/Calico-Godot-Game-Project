extends CharacterBody2D
class_name Player2D


const SPEED = 60.0
const JUMP_VELOCITY = -350.0
const BOUNCE_VELOCITY = -400.0
const GRAVITY = Vector2(0, 980)

var jump_buffer: bool = false

var is_alive = true

@onready var bounce_raycasts: Node2D = $BounceRaycasts
@onready var sprite_player: AnimatedSprite2D = $AnimatedSprite2D


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


func on_fell():
	is_alive = false
	print('I fell')
	$AnimatedSprite2D.rotate(deg_to_rad(-90))

func on_respawn():
	is_alive = true
	print('I respawned')
	$AnimatedSprite2D.rotate(deg_to_rad(90))
