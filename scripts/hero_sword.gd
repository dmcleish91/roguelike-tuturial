extends Area2D

@onready var sword: Sprite2D = $Sprite2D

func flip_sword(value: bool) -> void:
	if value == true:
		sword.flip_h = value
		sword.position = Vector2(-19,0)
	else:
		sword.flip_h = value
		sword.position = Vector2(9,0)
