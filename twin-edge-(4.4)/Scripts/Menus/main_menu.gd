extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

@onready var tutorial_popup = $"tutorial panel"
func _on_level_select_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/level_select.tscn")


func _on_toturial_pressed() -> void:
	tutorial_popup.visible = true
	
	


func _on_exit_pressed() -> void:
	get_tree().quit()
	


func _on_close_button_pressed() -> void:
	tutorial_popup.visible = false
