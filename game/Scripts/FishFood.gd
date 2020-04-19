extends KinematicBody2D

export var force_multiplier: float = 0.3

onready var default_position_x: float = position.x
onready var default_position_y: float = position.y

var dragging = false

func start_dragging():
	dragging = true
	rotation = 2.6

func stop_dragging():
	position = Vector2(default_position_x, default_position_y)
	rotation = 0
	dragging = false

func _ready():
	print(default_position_x)
	print(default_position_y)

func _input_event(viewport, event, shape_idx):
	if (event.is_action_pressed("drag")):
		start_dragging()

func _input(event):
	if (event.is_action_released("drag")):
		stop_dragging()

func _physics_process(delta):
	if (dragging):
		var fish_food_position = position
		var mouse_position = get_viewport().get_mouse_position()
		var force: Vector2 = mouse_position - fish_food_position
		force = force*force_multiplier
		move_and_collide(force)
		
