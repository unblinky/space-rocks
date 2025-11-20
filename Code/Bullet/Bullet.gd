extends ScreenWrapper
class_name Bullet

@onready var timer: Timer = $Timer

var player: Player # Data container.
var velocity: Vector2 = Vector2.ZERO # Direction.
var speed: float = 800.0 # pixel / sec. multiplier.

func _ready() -> void:
	timer.timeout.connect(Destroy)
	velocity = Vector2(sin(rotation), -cos(rotation)) * speed

func _process(delta: float) -> void:
	super._process(delta)
	position += velocity * delta

func Destroy():
	queue_free()
