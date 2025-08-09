extends CharacterBody2D
class_name Player2D


@export var enemies: Node

const SPEED: float           = 60.0
const JUMP_VELOCITY: float   = -350.0
const BOUNCE_VELOCITY: float = -400.0
const GRAVITY: Vector2       = Vector2(0, 980)

var jump_buffer: bool = false

signal health_changed(new_health: int)
signal lives_changed(new_lives: int)
@export var max_health: int = 3
var health: int = 3
var lives: int = 3

var is_alive: bool = true
var has_iframes: bool = false
@onready var hitbox: CollisionShape2D = $"CollisionShape2D"
@export var iframes_time: float = 2.0

@onready var bounce_raycasts: Node2D = $BounceRaycasts
@onready var sprite_player: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += GRAVITY * delta
	
	# Check if player is able to move (is alive)
	if not is_alive:
		velocity.y *= 0.99
		move_and_slide()
		apply_floor_snap()
		return
	
	# Jump higher when player hold the "jump" button (only upwards, when velocity.y < 0)
	if not is_on_floor() and not Input.is_action_pressed("jump") and velocity.y < 0:
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
	

# Called when the player gets hit. Deals some amount of damage to health, checks if a life should be lost 
# and triggers invicibility frames
func take_damage(damage: int):
	health -= damage
	print("I took damage, I have now {} health and {} lives".format([health, lives], "{}"))
	health_changed.emit(health)
	if health <= 0:
		_lose_life()
	else:
		_start_iframes()


# Triggers simplified iframe state, then exits the state again 
func _start_iframes():
	has_iframes = true
	sprite_player.modulate = Color(1, 1, 1, 0.5)
	await get_tree().create_timer(iframes_time).timeout
	sprite_player.modulate = Color(1, 1, 1, 1)
	has_iframes = false


# Called when player's health drops to or below 0, or when player has been killed by other means. Triggers death screen.
func _lose_life():
	# Lives setup
	lives -= 1
	lives_changed.emit(lives)
	if lives <= 0:
		print("I died")
	is_alive = false
	print('I lost 1 life')
	
	# Sprite setup
	sprite_player.play("idle")  # TODO: or "death" anim
	sprite_player.flip_h = false
	sprite_player.rotate(deg_to_rad(-90))
	

# Called when the player falls into the pit — special case of injury from killzones.
# For now, it only causes 1 life lost, might also cause unique death screen / animation / sounds.
func on_fell():
	_lose_life()


# Called from Level Manager to respawn the player. Changes player's state to Respawned, when it still waits for the 
# transition screen to finish, but moves him to the last visited checkpoint and restores his stats.
func on_respawn():
	health = max_health
	health_changed.emit(health)
	print('I respawned')
	sprite_player.rotate(deg_to_rad(90))


# Called from Level Manager to enable player's movement. Changes their state to Alive, when they can freely move again.
func on_revive():
	is_alive = true
