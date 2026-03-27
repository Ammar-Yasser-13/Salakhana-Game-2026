extends CharacterBody3D

#====={Enemy variables}=====> 
var player_visibility:bool = false
var player_position:Vector3
var Player:Node3D = null
@export_category("Enemy adjustable variables")
@export var Enemy_health:int = 1
@export var Enemy_rotation_speed:float = 5.3
@export var bullet_speed:float = 20
#====={Enemy reffrences}=====> 
@onready var Bullet_Scene = preload("res://scenes/pick ups/bullet_projectile.tscn")
@onready var marker_3d: Marker3D = $Marker3D
@onready var cooldown: Timer = $cooldown
#====={Enemy States}=====>
var Idle:bool = true
var dead:bool = false
var fighting:bool = false

func _physics_process(delta: float) -> void:
	if Player:
		player_position = Player.global_position
	Enemy_rotate(delta)
	Enemy_State_checker()
	can_shoot()
	move_and_slide()

#====={Enemy detect player}=====>
func player_detect(body: Node3D) -> void:
	if body.is_in_group("Player"):
		print("player entered")
		Player = body
		fighting = true

#====={Enemy undetect player}=====>
func Player_detect_exited(body: Node3D) -> void:
	if body.is_in_group("Player"):
		print("player exited")
		Player = null

#====={Enemy handle rotaition}=====>
func Enemy_rotate(delta) -> void:
	var direction = (player_position - global_position).normalized()
	var target_angle = atan2(direction.x, direction.z)
	var current_angle = rotation.y
	var new_angle = lerp_angle(current_angle, target_angle, Enemy_rotation_speed * delta)
	rotation.y = new_angle

#====={Enemy states}=====>
func Enemy_State_checker()->void:
#==> idle state
	if Enemy_health == 1 && Player == null:
		Idle = true
		dead = false
		fighting = false
		#print("idle")
#==> death state
	if Enemy_health < 1:
		Idle = false
		dead = true
		fighting = false
		#print("dead")
#==> fighting state
	if Enemy_health == 1 && Player:
		Idle = false
		dead = false
		fighting = true
		#print("fighting")

#====={Enemy damage taking}=====>
func Enemy_take_damage()-> void:
	Enemy_health -= 1
	print("enemy health " + str(Enemy_health))

#====={Enemy hurtbox}=====>
func bullet_hit(body: Node3D) -> void:
	#print("damaged")
	if body.is_in_group("bullet") :
		Enemy_take_damage()

#====={Enemy shooting setup player}=====>
func shoot_player()->void:

	var bullet = Bullet_Scene.instantiate()
	get_tree().current_scene.add_child(bullet)
	#==> positioning bullet
	if marker_3d:
		bullet.global_position = marker_3d.global_position
	else:
		bullet.global_position =  global_position + -transform.basis.z * 1.5
	#==> bullet speed and direction
	var direction_to_player = (Player.global_position - bullet.global_position).normalized()
	bullet.velocity = direction_to_player * bullet_speed

#====={Enemy shooting player}=====>
func can_shoot()->void:
	if fighting == true:
		shoot_player()
		cooldown.start()
