extends CharacterBody3D
#============================= Node References ==============================
@onready var head: Node3D = $Head
@onready var camera: Camera3D = $"Head/Player Camera"

#========================== Player Attributes ===============================
@export var CURRENT_SPEED = 5.0
@export var NORMAL_SPEED = 5.0
@export var SPRINT_SPEED_ADDITION = 2.0
@export var JUMP_VELOCITY = 4.5
@export var Sensitivity = 0.02


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	# Aiming
	if event is InputEventMouseMotion:
		# Handles rotation, Rotation on x axis is for the head object which will be responsible for aiming
		# Rotation on the y Axis is for the whole player so it moves in the right direction
		rotate_y(-event.relative.x * Sensitivity)
		head.rotate_x(-event.relative.y * Sensitivity )
		head.rotation.x = clamp(head.rotation.x,deg_to_rad(-60),deg_to_rad(90))

	#====================================================================================

	# Sprinting
	if Input.is_action_pressed("Sprint_Player"):
		CURRENT_SPEED = NORMAL_SPEED + SPRINT_SPEED_ADDITION
		camera.fov = 90
	if Input.is_action_just_released("Sprint_Player"):
		CURRENT_SPEED = NORMAL_SPEED
		camera.fov = 75
	
	#====================================================================================
	#Shooting
	if Input.is_action_just_pressed("Shoot_Player"):
		#this is a place holder until shooting is implemented
		print("Player is Shooting")

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump_Player") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Left_Player","Right_Player","Forward_Player","Backward_Player")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * CURRENT_SPEED
		velocity.z = direction.z * CURRENT_SPEED
	else:
		velocity.x =0
		velocity.z =0

	move_and_slide()
