extends CharacterBody2D

@onready var goblin_sprite: AnimatedSprite2D = $AnimatedSprite2D
var target: Node2D = null

func play_run() -> void:
	if goblin_sprite:
		goblin_sprite.play("run")

func play_idle() -> void:
	if goblin_sprite:
		goblin_sprite.play("idle")
		
func flip_direction(value: bool) -> void:
	goblin_sprite.flip_h = value


func _on_hurtbox_area_entered(area: Area2D) -> void:
	print("bestie don't hurt me please")


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		target = body
		print("Wait till I get clapping logic")


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		target = null
		print("Probably just the wind...")
