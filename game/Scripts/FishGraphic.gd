extends Node2D

export var animation_speed = 0.2


# Called when the node enters the scene tree for the first time.
func _ready():
	start_animation()

func start_animation():
	var animation_player:AnimationPlayer = $AnimationPlayer
	animation_player.play("SimpleFishAnimation")
	animation_player.playback_speed = animation_speed
