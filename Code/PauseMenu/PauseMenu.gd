extends PanelContainer
class_name PauseMenu

const MAIN = preload("res://Main/Main.tscn")
const PLAYER = preload("res://Player/Player.tscn")

@onready var title: Label = $VBox/Title
@onready var play_button: Button = $VBox/PlayButton
@onready var continue_button: Button = $VBox/ContinueButton
@onready var quit_button: Button = $VBox/QuitButton

var main: Main

func _ready() -> void:
	play_button.pressed.connect(OnPlayPressed)
	continue_button.pressed.connect(OnContinuePressed)
	quit_button.pressed.connect(OnQuitPressed)
	
	play_button.show()
	continue_button.hide()
	quit_button.show()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		TogglePause()

func TogglePause():
	if get_tree().paused:
		get_tree().paused = false
		hide()
	else:
		show()
		get_tree().paused = true
		title.text = "Game Paused"
		play_button.hide()
		continue_button.show()
		quit_button.hide()

func GameOver():
	show()
	title.text = "Game Over"
	play_button.text = "Play again?"
	play_button.show()
	continue_button.hide()
	quit_button.hide()

func OnPlayPressed():
	hide()
	
	# Kill main if it still exists.
	if main != null:
		main.queue_free()
	
	# Load a fresh game.
	main = MAIN.instantiate()
	add_child(main)
	
	# Instance Player.
	var player: Player = PLAYER.instantiate()
	player.menu = self
	main.add_child(player) # Freed when main is destroyed.

func OnContinuePressed():
	get_tree().paused = false
	hide()

func OnQuitPressed():
	get_tree().quit()
