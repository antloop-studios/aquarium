extends KinematicBody2D

export var force_multiplier: float = 0.3

export var shake_minimum: float = 40

onready var default_position_x: float = position.x
onready var default_position_y: float = position.y

export var follow_speed: float = 10

var is_shaking = false

var dragging = false
var force: Vector2 = Vector2.ZERO

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
		var mouse_position = get_viewport().get_mouse_position()
		var target_force   = mouse_position - position

		if position.distance_to(mouse_position) > 1:
			force      = lerp(force, target_force * force_multiplier, delta * follow_speed)
			is_shaking = position.distance_to(mouse_position) > shake_minimum

			$FishFood.flip_v = is_shaking

			if is_shaking:
				spawn_food()

			move_and_collide(force)

signal food_is_served(food_pos)

func spawn_food():
	emit_signal("food_is_served", Vector2.ZERO)
