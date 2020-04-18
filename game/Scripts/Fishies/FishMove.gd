extends KinematicBody2D

export var speed: float = 0.5
export var scramble_interval_min = 10 # seconds
export var scramble_interval_max = 100 # seconds

# overclock this piece of shit (nice debug too)
export var clock_modifier = 10

# max scramble at once
export var scramble_factor_angle = TAU
export var scramble_factor_speed = 0.5

export var interpolation_weight = 2

# bool for right
var direction: bool = false
# movement angle, not facing angle
var angle = 0

var target_angle = 0
var target_speed = 0

var clock = 0
var next_scramble = 0

func _ready():
	mix_it_up()

func mix_it_up():
	target_angle = angle + rand_range(-scramble_factor_angle, scramble_factor_angle)
	target_speed = rand_range(speed * scramble_factor_speed, speed + speed * (1 - scramble_factor_speed))

func _process(dt):
	# HANDLE TARGETS

	if angle != target_angle:
		angle = lerp(angle, target_angle, dt * interpolation_weight)

	if speed != target_speed:
		speed = lerp(speed, target_speed, dt * interpolation_weight)

	# MOVE THE FISHY

	var delta = Vector2.ZERO

	delta.x = cos(angle) * speed
	delta.y = sin(angle) * speed

	move_and_collide(delta)

	rotation = angle * 0.1

	var last_dir = direction
	direction = delta.x > 0
	
	if last_dir != direction:
		get_node("Sprite").set_flip_h(direction)

	# CHECK THE TIME !!

	clock += dt * clock_modifier
	
	if clock >= next_scramble:
		clock = 0
		next_scramble = rand_range(scramble_interval_min, scramble_interval_max)

		mix_it_up()
