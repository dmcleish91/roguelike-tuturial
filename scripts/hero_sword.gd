extends Area2D

@onready var sword = $Sprite2D

func flip_sword(value: bool):
	sword.flip_h = value
