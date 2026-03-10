extends Area3D

@onready var root_scene: Node3D = $"Root Scene"
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var health_pickup: AudioStreamPlayer3D = $HealthPickup

func _process(_delta: float) -> void:
	root_scene.rotate_y(0.02)

func _on_body_entered(_body: Node3D) -> void:
	Game_Manger.Current_health += 1
	print("+1 HP")
	health_pickup.play()
	collision_shape_3d.disabled = true
	root_scene.visible = false
