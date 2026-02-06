extends Area3D

@onready var root_scene: Node3D = $"Root Scene"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	root_scene.rotate_y(0.02)
	

func _on_body_entered(_body: Node3D) -> void:
	print("bullets +3")
	queue_free()
