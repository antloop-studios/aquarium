extends KinematicBody2D

export var speed: float = 0.5
export var scramble_interval_min = 10 # seconds
export var scramble_interval_max = 100 # seconds

export var max_scramble: float = 0.5
# overclock this piece of shit (nice debug too)
export var clock_modifier = 10

# max scramble at once
export var scramble_factor_angle = TAU
export var scramble_factor_speed = 0.75

export var interpolation_weight = 2

onready var original_speed = speed

# bool for right
var direction: bool = false
# movement angle, not facing angle
var angle = 0

var target_angle = 0
var target_speed = 0

var clock = 0
var next_scramble = 0

onready var aqua_width: float = get_parent().WIDTH
onready var aqua_height: float = get_parent().HEIGHT

export var fish_types = 3

var current_fish = rand_range(0, fish_types)

func _ready():
	$Graphics.get_child(current_fish).show()
	
	mix_it_up()

func mix_it_up():
	target_angle = angle + rand_range(-scramble_factor_angle, scramble_factor_angle)
	var optimus_prime  = rand_range(speed * scramble_factor_speed, speed + speed * (1 - scramble_factor_speed))

	if (original_speed - optimus_prime) / original_speed < max_scramble and optimus_prime < target_speed:
		target_speed = optimus_prime

	if (original_speed - optimus_prime) / original_speed < max_scramble * 1.5 and optimus_prime > target_speed:
		target_speed = optimus_prime

func _process(dt):
	# HANDLE TARGETS

	if angle != target_angle:
		angle = lerp(angle, target_angle, dt * interpolation_weight)

	if speed != target_speed:
		speed = lerp(speed, target_speed, dt * interpolation_weight)

	# MOVE THE FISHY

	var delta = Vector2.ZERO

	delta.x = cos(angle) * speed * dt * 50
	delta.y = sin(angle) * speed * dt * 50

	move_and_collide(delta)
	
	$Graphics.get_child(current_fish).set_animation_speed(speed)

	# 60 is a magic number for fish height
	position.x = clamp(position.x, 60, aqua_width - 60)
	position.y = clamp(position.y, 50, aqua_height - 50)

	if abs(rad2deg(angle)) < 30 and abs(rad2deg(angle)) > -30:
		rotation = angle * 0.1

	var last_dir = direction
	direction = delta.x > 0

	if last_dir != direction:
		$Graphics.scale.x *= -1

	# CHECK THE TIME !!

	clock += dt * clock_modifier
	
	if clock >= next_scramble:
		clock = 0
		next_scramble = rand_range(scramble_interval_min, scramble_interval_max)

		mix_it_up()

func chase_food():
	pass

func on_FishFood_food_is_served():
	print("hey")
