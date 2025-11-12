extends Area2D
class_name ScreenWrapper

func _process(delta: float) -> void:
	if position.x < 0:
		position.x = get_viewport().size.x
	if position.x > get_viewport().size.x:
		position.x = 0
	if position.y < 0:
		position.y = get_viewport().size .y
	if position.y > get_viewport().size.y:
		position.y = 0
	
	pass
