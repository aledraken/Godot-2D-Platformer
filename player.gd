extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var max_jumps: int = 1
var jump_counter: int

var was_on_floor: bool

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jump_counter = 0

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		jump_counter += 1
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0, SPEED)

	was_on_floor = is_on_floor()

	move_and_slide()

	if was_on_floor and not is_on_floor() and (jump_counter < max_jumps):
		print("shi")
