extends Node

#==================================[ Player Stats ]========================================
const Max_Health:int = 4
const Max_bullets:int = 6
const Min_Health:int = 0
const Min_bullets:int = 0
@export var Current_health:int = Max_Health 
@export var Current_bullets:int = Max_bullets
#==================================[ Level data ]========================================
@export_category("Level data")
@export var Enemies_level_counter:int = 0
@export var Level_1_Enemies_number:int = 8
@export var Level_2_Enemies_number:int = 5
var Current_enemies:int
var current_level:int
#==========================================================================================

func _process(_delta: float) -> void:
#==================================[ invetory Limit ]========================================
#=====[ Health ]=====
	if Current_health <= 0:
		Current_health = Min_Health
		Restart()
	if Current_health >= 4:
		Current_health = Max_Health
#=====[ Bullets ]=====
	if Current_bullets > 6:
		Current_bullets = Max_bullets
	if Current_bullets <= 0:
		Current_bullets = Min_bullets
	Level_switcher()
	Enemies_counter()
	#=========================================================================================

#====> called when player dies
func Restart():
	#=====[ Restart current level & fills inventory ]=====
	get_tree().reload_current_scene()
	Current_health = Max_Health
	Current_bullets = Max_bullets

#====> switches level 1 to level 2 when all enemies are killed
func Level_switcher()->void:
	if Game_Manger.Current_enemies <= 0 && Game_Manger.current_level >= 1:
		get_tree().change_scene_to_file("res://scenes/Levels/model_level_2.tscn")
		Game_Manger.Enemies_level_counter = 2

func Enemies_counter():
	Current_enemies = get_tree().get_nodes_in_group("Enemy").size()
