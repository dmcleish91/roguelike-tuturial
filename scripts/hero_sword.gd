extends Area2D

@onready var sword: Sprite2D = $Sprite2D
@onready var sword_animation_player: AnimationPlayer = $SwordAnimationPlayer
@onready var sword_collision: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	sword_collision.disabled = true
	sword_animation_player.animation_finished.connect(_on_animation_finished)

func sword_attack() -> void:
	sword_animation_player.stop()
	sword_collision.disabled = false
	sword_animation_player.play("attack")

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "attack":
		sword_animation_player.play("RESET")
		sword_collision.disabled = true
