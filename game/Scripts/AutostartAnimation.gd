extends AnimationPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	start_animation()
	
func start_animation():
	var this:AnimationPlayer = get_node(".")
	this.play("SimpleFishAnimation")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
