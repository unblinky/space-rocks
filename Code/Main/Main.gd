extends Node
class_name Main

const ROCK = preload("res://Rock/Rock.tscn")
const UNIDENTIFIED_FLYING_OBJECT = preload("res://UFO/UFO.tscn")

@onready var timer: Timer = $Timer
@onready var pause_menu: PauseMenu = $PauseMenu

var rocks: Array[Rock]
var rock_count = 3 # Increase for level dificulty.

func _ready() -> void:
	timer.timeout.connect(SpawnUFO)
	pause_menu.show()
	NextLevel()
	#SpawnRocks(rock_count)

func SpawnRocks(num: int):
	for i in num:
		var rock = ROCK.instantiate()
		rock.main = self
		add_child(rock)
		rocks.append(rock)

func SpawnUFO():
	var ufo = UNIDENTIFIED_FLYING_OBJECT.instantiate()
	ufo.position.y = randf_range(0, get_viewport().size.y)
	add_child(ufo)

func RemoveRock(rock: Rock):
	rocks.erase(rock)
	if rocks.is_empty():
		# TODO: Add timer?
		NextLevel()

func NextLevel():
	rock_count += 1
	SpawnRocks.call_deferred(rock_count)

func GameOver():
	pause_menu.show()
	# TODO: Edit message.
