extends ScreenWrapper
class_name Rock

@onready var sprite: AnimatedSprite2D = $Sprite

var main: Main
var max_speed: float = 300.0
var velocity: Vector2
var point_value: int = 1

func _ready() -> void:
	area_entered.connect(OnAreaEntered)
	velocity = Vector2(randf_range(-max_speed, max_speed), randf_range(-max_speed, max_speed))
	sprite.frame = randi_range(0, 3) # TODO: Pull this magic number.

func _process(delta: float) -> void:
	super._process(delta)
	position += velocity * delta

func OnAreaEntered(area: Area2D):
	#print(area)
	if area is Ship:
		area.Destroy() # TODO: Add to `Ship.gd`.
		Destroy()
	
	if area is Bullet:
		area.ship.player.UpdateScore(point_value)
		area.Destroy() # TODO: Should we do penetration? Feature creep.
		Destroy()

func Destroy():
	main.RemoveRock(self)
	queue_free()
