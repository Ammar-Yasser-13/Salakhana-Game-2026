extends CharacterBody3D
var dir : Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	move_and_slide()

func start ():
	velocity = dir.normalized() * 300
	
func end ():
	velocity = Vector3(0,0,0)


func _on_bullet_area_body_entered(body: Node3D) -> void:
	if not body.is_in_group("Player"):
		if body.is_in_group("Enemy"):
			body.die()
		queue_free()
