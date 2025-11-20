extends ScreenWrapper
class_name Ship

const BULLET = preload("res://Bullet/Bullet.tscn")

var player: Player
var turn_speed: float = 360.0 # degrees / sec.
var direction: Vector2 = Vector2.ZERO # direction.
var speed: float = 25.0 # multiplier.
var max_speed: float = 100.0 # speed clamp.
var velocity: Vector2 = Vector2.ZERO # direction * speed.

func _process(delta: float) -> void:
	super._process(delta)
	
	if Input.is_action_pressed("turn_ccw"):
		rotation_degrees -= turn_speed * delta
	if Input.is_action_pressed("turn_cw"):
		rotation_degrees += turn_speed * delta
	if Input.is_action_pressed("thrust"):
		direction = Vector2(sin(rotation), -cos(rotation))
		velocity += direction * speed
		velocity = velocity.limit_length(max_speed)
	
	if Input.is_action_just_pressed("fire"):
		SpawnBullet()

	position += velocity * delta

func SpawnBullet():
	var bullet: Bullet = BULLET.instantiate()
	bullet.player = player
	bullet.position = position
	bullet.rotation = rotation
	get_parent().add_child(bullet)

func Destroy():
	player.CheckGameOver()
	queue_free()
	# TODO: 
	# - Play SFX.
	# - Play partical explosion.
