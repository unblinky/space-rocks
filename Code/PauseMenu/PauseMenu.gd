extends PanelContainer
class_name PauseMenu

const PLAYER = preload("res://Player/Player.tscn")

@onready var title: Label = $VBox/Title
@onready var play_button: Button = $VBox/PlayButton
@onready var quit_button: Button = $VBox/QuitButton

func _ready() -> void:
	play_button.pressed.connect(OnPlayPressed)
	quit_button.pressed.connect(OnQuitPressed)

func OnPlayPressed():
	# TODO: Migrate into Main?
	hide()
	var player: Player = PLAYER.instantiate()
	player.main = get_parent() # HACK: Better organizing?
	get_parent().add_child(player)

func OnQuitPressed():
	get_tree().quit()
