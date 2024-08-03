extends CharacterBody2D
class_name Player
@onready var PlayerSprite = $PlayerSprite

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func update_animations(direction):
	if is_on_floor():
		if direction==0:
			PlayerSprite.play("Idle")
		else:
			PlayerSprite.play("Run")
	else:
		if velocity.y<0:
			PlayerSprite.play("Jump")
		else:
			PlayerSprite.play("Fall")
			

func jump(jumpvelocity):
	#print("JUMP CALLED")
	#print(jumpvelocity)
	velocity.y = jumpvelocity

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump"): #and is_on_floor():
		jump(JUMP_VELOCITY)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("MoveLeft", "MoveRight")
	if direction:
		velocity.x = direction * SPEED
		PlayerSprite.flip_h = (direction == -1)
	else:
		velocity.x = 0 #move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	update_animations(direction)
	
