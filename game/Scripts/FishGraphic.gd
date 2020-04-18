extends Node2D

export var animation_speed = 0.2

onready var animation_player:AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	start_animation()

func start_animation():
	var animation = animation_player.get_animation_list()[0]
	animation_player.play(animation)
	animation_player.playback_speed = animation_speed

func set_animation_speed(speed: float):
	animation_player.playback_speed = speed
	
func get_animation_speed():
	return animation_player.playback_speed
