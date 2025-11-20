extends Area2D
class_name UFO

@export var vertical_travel = false
@onready var timer: Timer = $Timer

var traveling_left: bool = false
var speed: float = 100.0 # px / sec.
var y_direction: float = 0.0
var point_value: int = 50

func _ready() -> void:
	## Signal Hooks.
	timer.timeout.connect(OnTimedOut) # Signal hook
	area_entered.connect(OnAreaEntered)
	
	## Init here...
	traveling_left = randi_range(0, 1)
	if traveling_left:
		position.x = get_viewport().size.x
	else:
		position.x = 0.0

func _process(delta: float) -> void:
	if traveling_left:
		position.x -= speed * delta
	else:
		position.x += speed * delta
	
	position.y += y_direction * speed * delta
	
	# Screen wrapping. Vertical only.
	if position.y < 0:
		position.y = get_viewport().size.y
	if position.y > get_viewport().size.y:
		position.y = 0
	
	# Screen death.
	if position.x < 0:
		queue_free()
	if position.x > get_viewport().size.x:
		queue_free()

func OnTimedOut():
	if y_direction != 0:
		y_direction = 0
	else:
		if randi() % 2:
			y_direction = 1
		else:
			y_direction = -1

func OnAreaEntered(area: Area2D):
	if area is Bullet:
		area.player.UpdateScore(point_value)
		area.Destroy()
		queue_free()
		
