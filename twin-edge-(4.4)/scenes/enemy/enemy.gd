extends Node3D

# إعدادات العدو
@export var shoot_cooldown: float = 1.5
@export var bullet_scene: PackedScene
@export var rotation_speed: float = 5.0

# الحالة
var player: Node3D
var can_shoot := true

# Nodes جاهزة
@onready var muzzle = $Marker3D
@onready var shoot_timer = $Timer
@onready var anim=$"Root Scene/AnimationPlayer"


func _ready():
	# Dummy Player للتجربة
	player = get_tree().get_first_node_in_group("player")  

	# إعداد التايمر
	shoot_timer.wait_time = shoot_cooldown
	shoot_timer.one_shot = true
	shoot_timer.timeout.connect(_on_shoot_timer_timeout)


func _process(delta):
	if player == null:
		return

	# تابع اللاعب
	look_at_player(delta)

	# اطلق الرصاصة لو جاهز
	if can_shoot:
		
		shoot()
		anim.play("CharacterArmature|Gun_Shoot")


func look_at_player(delta):
	var target_rotation = global_transform.looking_at(player.global_position, Vector3.UP)
	global_transform = global_transform.interpolate_with(target_rotation, rotation_speed * delta)


func shoot():
	can_shoot = false

	# اصنع الرصاصة
	var bullet = bullet_scene.instantiate() as Area3D
	get_tree().current_scene.add_child(bullet)

	# ضعها عند الـ Muzzle
	bullet.global_transform.origin = muzzle.global_transform.origin

	# احسب اتجاه الحركة نحو اللاعب
	var dir = (player.global_transform.origin - muzzle.global_transform.origin).normalized()
	bullet.direction = dir  # خاصية الرصاصة تتحرك بها

	# شغّل التايمر
	shoot_timer.start()


func _on_shoot_timer_timeout():
	can_shoot = true
