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
