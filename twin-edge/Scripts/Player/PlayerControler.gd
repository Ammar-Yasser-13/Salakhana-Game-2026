extends CharacterBody3D
#============================= Node References ==============================
@onready var head: Node3D = $Head
@onready var crosshair: Node3D = $"Head/Aim Crosshair"
@onready var camera: Camera3D = $"Head/Player Camera"
@onready var collider: CollisionShape3D = $"Player Collider"
@onready var Dash_Timer: Timer = $"Dash Timer"
@onready var gun_timer: Timer = $"Gun Timer"
@onready var empty_shot: AudioStreamPlayer = $sounds/EmptyShot
@onready var gun_shot: AudioStreamPlayer = $sounds/GunShot
@onready var jump: AudioStreamPlayer = $sounds/Jump
@onready var take_damage: AudioStreamPlayer = $sounds/TakeDamage
#========================== Player Attributes ===============================
@export var SPEED = 75.0
@export var Crouch_Multiplier = 1.0 #(0.5)
@export var Dash_Multiplier = 1.0 #(3.0)
@export var Sprint_Multiplier = 1.0 #(1.5)
@export var JUMP_VELOCITY = 50.0
@export var Mouse_Sensitivity = 0.02
@export var Controller_Sensitivity = 0.05
#===============================State Controllers===========================
var Controller_Direction = null
var Is_Crouched = false
var Can_Shoot = true
#================================Bullet=======================================
var Bullet_Scene = preload("res://scenes/pick ups/bullet_projectile.tscn")
var Bullet_Pool =[]

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		


func _unhandled_input(event: InputEvent) -> void:
	# Aiming
	head.rotation.x = clamp(head.rotation.x,deg_to_rad(-60),deg_to_rad(90))
	# Mouse
	if event is InputEventMouseMotion:
		# Handles rotation, Rotation on x axis is for the head object which will be responsible for aiming
		# Rotation on the y Axis is for the whole player so it moves in the right direction
		rotate_y(-event.relative.x * Mouse_Sensitivity)
		head.rotate_x(-event.relative.y * Mouse_Sensitivity )
	# Controller aiming is in _physics_process
	#====================================================================================

	# Sprinting
	if Input.is_action_pressed("Sprint_Player"):
		Sprint_Multiplier = 1.5
	if Input.is_action_just_released("Sprint_Player"):
		Sprint_Multiplier = 1.0
	
	#====================================================================================
	#Shooting
	if Input.is_action_just_pressed("Shoot_Player") && Game_Manger.Current_bullets > 0  && Can_Shoot:
		#this is a place holder until shooting is implemented
		Spawn_Bullet()
		Game_Manger.Current_bullets -= 1
		gun_shot.play()
		print(Game_Manger.Current_bullets)
		Can_Shoot = false
		gun_timer.start(0.0)
	# user feedback for no ammo
	elif Input.is_action_just_pressed("Shoot_Player") && Game_Manger.Current_bullets <= 0 && Can_Shoot:
		empty_shot.play()
	#===================================================================================
	#Crouching
	if Input.is_action_just_pressed("Crouch_Player"):
		Change_Crouch_State()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump_Player") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Left_Player","Right_Player","Forward_Player","Backward_Player")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED*Dash_Multiplier*Sprint_Multiplier*Crouch_Multiplier
		velocity.z = direction.z * SPEED*Dash_Multiplier*Sprint_Multiplier*Crouch_Multiplier
	else:
		velocity.x =0
		velocity.z =0
	# Aiming (Controller)
	# Added controller aiming here because unhandeled input handles input CHANGE not streams
	Controller_Direction = Input.get_vector("Camera_Left_Player","Camera_Right_Player","Camera_Down_Player","Camera_Up_Player")
	if Controller_Direction:
		head.rotate_x(Controller_Direction.y*Controller_Sensitivity)
		rotate_y(-Controller_Direction.x*Controller_Sensitivity)

	move_and_slide()
	#print(velocity.length())
	
		#=====[ dummy health testing ]=====
	if Input.is_action_just_pressed("Dummy_button_damage"):
		Take_damage()
		print( "your health: " + str(Game_Manger.Current_health))

func Change_Crouch_State() -> void:
	Is_Crouched = !Is_Crouched
	match Is_Crouched:
		true :
			collider.shape.height = 10
			Crouch_Multiplier = 0.5
			if velocity.length() > SPEED:
				Dash_Multiplier = 3.0
				Dash_Timer.start(0.0)
		false :
			collider.shape.height = 20
			Crouch_Multiplier = 1

func Spawn_Bullet ():
		var Bullet = Bullet_Scene.instantiate()
		get_parent().add_child(Bullet)
		Bullet.dir = crosshair.global_position - head.global_position
		Bullet.global_rotation =  head.global_rotation
		Bullet.global_position = head.global_position
		Bullet.global_position.y = head.global_position.y - 3
	
		
		Bullet.show()
		Bullet.set_physics_process(true)
		Bullet.start()

func Despawn_Bullet (Bullet):
	Bullet.hide()
	Bullet.set_physics_process(false)
	Bullet.end()
	Bullet_Pool.append(Bullet)

func _on_dash_timer_timeout() -> void:
	Dash_Multiplier=1


func _on_gun_timer_timeout() -> void:
	Can_Shoot = true

# damages the player and plays sound for feedback
func Take_damage():
	Game_Manger.Current_health -= 1
	take_damage.play()
