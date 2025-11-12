extends Node
class_name Main

const ROCK = preload("res://Rock/Rock.tscn")
const UNIDENTIFIED_FLYING_OBJECT = preload("res://UFO/UFO.tscn")
@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.timeout.connect(SpawnUFO)
	SpawnRocks(6)

func SpawnRocks(num: int):
	for i in num:
		var rock = ROCK.instantiate()
		add_child(rock)

func SpawnUFO():
	var ufo = UNIDENTIFIED_FLYING_OBJECT.instantiate()
	ufo.position.y = randf_range(0, get_viewport().size.y)
	add_child(ufo)
	
