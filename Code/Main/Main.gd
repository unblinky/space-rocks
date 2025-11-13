extends Node
class_name Main

const ROCK = preload("res://Rock/Rock.tscn")
const UNIDENTIFIED_FLYING_OBJECT = preload("res://UFO/UFO.tscn")

@onready var timer: Timer = $Timer
@onready var pause_menu: PauseMenu = $PauseMenu

var rock_count = 5

func _ready() -> void:
	timer.timeout.connect(SpawnUFO)
	pause_menu.show()
	SpawnRocks(rock_count)

func SpawnRocks(num: int):
	for i in num:
		var rock = ROCK.instantiate()
		rock.main = self
		add_child(rock)

func SpawnUFO():
	var ufo = UNIDENTIFIED_FLYING_OBJECT.instantiate()
	ufo.position.y = randf_range(0, get_viewport().size.y)
	add_child(ufo)

func UpdateRockCount(delta_count: int):
	rock_count += delta_count
	if rock_count <= 0:
		# FIXME: Flush error. queue_free?
		SpawnRocks(3)
		rock_count = 3

func GameOver():
	pause_menu.show()
	# TODO: Edit message.
