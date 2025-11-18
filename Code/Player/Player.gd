extends PanelContainer
class_name Player

const SHIP = preload("res://Ship/Ship.tscn")
const LIFE = preload("res://Player/assets/Life.tscn")

@onready var score_ui: Label = $VBox/ScoreUI
@onready var lives_ui: HBoxContainer = $VBox/LivesUI

var score: int = 0
var lives: int = 2

# Current ship in viewport.
var ship: Ship
var main: Main

func _ready() -> void:
	UpdateScore(0)
	UpdateLives(0)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("launch"):
		if self.ship == null and lives > 0:
			main.GameOver() # FIXME: !!!!!!!!!!!!!!
			SpawnShip()
			UpdateLives(-1)


func SpawnShip():
	var new_ship: Ship = SHIP.instantiate()
	new_ship.player = self
	new_ship.position = get_viewport().size / 2
	add_child(new_ship)
	ship = new_ship

func UpdateScore(delta_score):
	score += delta_score
	score_ui.text = str(score)

func UpdateLives(delta_lives):
	lives += delta_lives
	for child in lives_ui.get_children():
		child.queue_free()
	
	for i in lives:
		var life = LIFE.instantiate()
		lives_ui.add_child(life)

func LivesGone():
	if lives <= 0 && ship == null:
		main.GameOver()
