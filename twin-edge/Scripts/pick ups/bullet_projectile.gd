extends CharacterBody3D
var dir : Vector3

var shot_byenemy = false
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
	if !shot_byenemy:
		if not body.is_in_group("Player"):
			if body.is_in_group("Enemy"):
				body.die()
			queue_free()
	else:
		if not body.is_in_group("Enemy"):
			if body.is_in_group("Player"):
				body.Take_damage()

func change_shotbyenemy ():
	shot_byenemy = true
