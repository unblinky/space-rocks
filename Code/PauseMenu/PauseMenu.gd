extends PanelContainer
class_name PauseMenu

const PLAYER = preload("res://Player/Player.tscn")

@onready var title: Label = $VBox/Title
@onready var play_button: Button = $VBox/PlayButton
@onready var continue_button: Button = $VBox/ContinueButton
@onready var quit_button: Button = $VBox/QuitButton

func _ready() -> void:
	play_button.pressed.connect(OnPlayPressed)
	continue_button.pressed.connect(OnContinuePressed)
	quit_button.pressed.connect(OnQuitPressed)
	
	play_button.show()
	continue_button.hide()
	quit_button.show()

func OnPlayPressed():
	# TODO: Migrate into Main?
	hide()
	var player: Player = PLAYER.instantiate()
	player.main = get_parent() # HACK: Better organizing?
	get_parent().add_child(player)

func OnContinuePressed():
	get_tree().paused = false
	hide()

func OnQuitPressed():
	get_tree().quit()
