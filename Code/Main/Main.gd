extends Node
class_name Main

const ROCK = preload("res://Rock/Rock.tscn")
const UNIDENTIFIED_FLYING_OBJECT = preload("res://UFO/UFO.tscn")

@onready var timer: Timer = $Timer
@onready var pause_menu: PauseMenu = $PauseMenu

var rock_difficulty = 1
var rocks: Array[Rock]

func _ready() -> void:
	timer.timeout.connect(SpawnUFO)
	pause_menu.show()
	NextLevel()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = true
		pause_menu.show()
		pause_menu.title.text = "Game Paused"
		pause_menu.play_button.hide()
		pause_menu.quit_button.hide()
		pause_menu.continue_button.show()

func SpawnRocks(num: int, rock: Rock):
	for i in num:
		var new_rock = ROCK.instantiate()
		new_rock.main = self
		
		if rock != null:
			new_rock.position = rock.position
			new_rock.scale = rock.scale * 0.5
		
		add_child.call_deferred(new_rock)
		rocks.append(new_rock)


func SpawnUFO():
	var ufo = UNIDENTIFIED_FLYING_OBJECT.instantiate()
	ufo.position.y = randf_range(0, get_viewport().size.y)
	add_child(ufo)

func RemoveRock(rock: Rock):
	if rock.scale.x > 0.25:
		SpawnRocks(2, rock)
	
	rocks.erase(rock)
	if rocks.is_empty():
		NextLevel()

func NextLevel():
	rock_difficulty += 1
	SpawnRocks(rock_difficulty, null)

func GameOver():
	#pause_menu.show()
	# TODO: Edit message.
	print("Game Over")
	pass
