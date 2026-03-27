extends CharacterBody3D

#====={Enemy stats}=====> 
var player_visablity:bool = false
var player_position:Vector3
var Player:Node3D = null
@export var Enemy_health:int = 1
@export var Enemy_rotation_speed:float = 5.3

func _physics_process(delta: float) -> void:
	if Player:
		player_position = Player.global_position
	Enemy_rotate(delta)
	move_and_slide()

#====={Enemy detect player}=====>
func player_detect(body: Node3D) -> void:
	if body.is_in_group("Player"):
		print("player entered")
		Player = body

#====={Enemy undetect player}=====>
func Player_detect_exited(body: Node3D) -> void:
	if body.is_in_group("Player"):
		print("player exited")
		Player = null

#====={Enemy undetect player}=====>
func Enemy_rotate(delta) -> void:
	var direction = (player_position - global_position).normalized()
	var target_angle = atan2(direction.x, direction.z)
	var current_angle = rotation.y
	var new_angle = lerp_angle(current_angle, target_angle, Enemy_rotation_speed * delta)
	rotation.y = new_angle

#====={Enemy undetect player}=====>
