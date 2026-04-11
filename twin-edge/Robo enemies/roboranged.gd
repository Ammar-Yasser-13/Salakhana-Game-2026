extends CharacterBody3D
var enemy_bullet_load = preload("res://Robo enemies/enemy bullet.tscn") 
@onready var aim_1: Node3D = $"aim 1"
@onready var aim_2: Node3D = $"aim 2"

@onready var player: CharacterBody3D = %Player
@onready var animation: AnimationPlayer = $AnimationPlayer
var reached_Player = false
var dead = false
var chase = false
@onready var collisionshape3d: CollisionShape3D = $CollisionShape3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not dead:
		velocity = get_gravity()
		if is_on_floor() and not chase:
			animation.play("CharacterArmature|Idle")
			look_at(player.position)
			rotation.x =0
			rotation.z =0
		else:
			if is_on_floor() and chase :
				animation.play("CharacterArmature|Shoot")
				look_at(player.position)
				rotation.x =0
				rotation.z =0
		move_and_slide()

func die ():
	if not dead:
		animation.play("CharacterArmature|Death")
		dead = true
		Game_Manger.Enemies_killed += 1
		collisionshape3d.disabled = true



func _on_chase_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player") :
		chase = true


func _on_chase_area_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player") :
		chase = false

func shoot():
	var bullet = enemy_bullet_load.instantiate()
	get_tree().root.add_child(bullet)
	bullet.global_position = aim_1.global_position
	bullet.dir = aim_1.global_position - aim_2.global_position
	bullet.start() 
	
