extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")

#====> selcets level 1
func Level_1_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Levels/model_level_1.tscn")
	Game_Manger.level_one = true
	Game_Manger.level_two = false

#====> selcets level 2
func Level_2_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Levels/model_level_2.tscn")
	Game_Manger.level_two = true
	Game_Manger.level_one = false
