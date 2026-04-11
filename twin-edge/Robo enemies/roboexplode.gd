extends CharacterBody3D
@onready var player: CharacterBody3D = %Player
@onready var animation: AnimationPlayer = $"Root Scene/AnimationPlayer"
var reached_Player = false
var dead = false
@onready var damage_collision: CollisionShape3D = $"Root Scene/RootNode/CharacterArmature/Skeleton3D/Head/Head_end/Damage area/CollisionShape3D"
var chase = false
@onready var co3d: CollisionShape3D = $Area3D/CollisionShape3D
@onready var shape3d: CollisionShape3D = $CollisionShape3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not dead:
		if is_on_floor() and !reached_Player && chase:
			look_at(player.position)
			rotation.x =0
			rotation.z =0
			velocity = (player.position - position).normalized()*150
			animation.play("CharacterArmature|Run")
		else:
			velocity = get_gravity()
			if is_on_floor() and reached_Player:
				animation.play("CharacterArmature|Attack")
		move_and_slide()
 


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player") && not dead :
		reached_Player = true
		damage_collision.disabled = false


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player") :
		reached_Player = false
		damage_collision.disabled = true
		
func die ():
	damage_collision.disabled = true
	Game_Manger.Enemies_killed += 1
	co3d.disabled = true
	shape3d.disabled = true
	if not dead:
		animation.play("CharacterArmature|Death")
		
		dead = true
		


func _on_damage_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player") :
		body.Take_damage()


func _on_chase_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player") :
		chase = true


func _on_chase_area_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player") :
		chase = false
