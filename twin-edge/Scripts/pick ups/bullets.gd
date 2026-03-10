extends Area3D

@onready var taking_a_bullet: AudioStreamPlayer = $TakingABullet
@onready var root_scene: Node3D = $"Root Scene"
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

func _process(_delta: float) -> void:
	root_scene.rotate_y(0.02)

func _on_body_entered(_body: Node3D) -> void:
	Game_Manger.Current_bullets += 3
	taking_a_bullet.play()
	print("bullets +3")
	collision_shape_3d.disabled = true
	root_scene.visible = false
	await taking_a_bullet.finished
