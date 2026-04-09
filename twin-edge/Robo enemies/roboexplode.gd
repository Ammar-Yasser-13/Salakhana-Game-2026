extends CharacterBody3D
@onready var player: CharacterBody3D = %Player
@onready var animation: AnimationPlayer = $"Root Scene/AnimationPlayer"
var reached_Player = false
var dead = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not dead:
		if is_on_floor() and !reached_Player:
			look_at(player.position)
			rotation.x =0
			rotation.z =0
			velocity = (player.position - position).normalized()*150
			animation.play("CharacterArmature|Run")
		else:
			velocity = get_gravity()
		move_and_slide()
		if is_on_floor() and reached_Player:
			animation.play("CharacterArmature|Attack")


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player") :
		reached_Player = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player") :
		reached_Player = false
func die ():
	if not dead:
		animation.play("CharacterArmature|Death")
		dead = true
