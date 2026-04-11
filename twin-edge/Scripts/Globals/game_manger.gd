extends Node

#==================================[ Player Stats ]========================================
const Max_Health:int = 4
const Max_bullets:int = 6
const Min_Health:int = 0
const Min_bullets:int = 0
@export var Current_health:int = Max_Health 
@export var Current_bullets:int = Max_bullets
#==================================[ Level data ]========================================
@onready var Max_Enemies_Num:int
var Current_enemies:int = Max_Enemies_Num
var level_one:bool = false
var level_two:bool = false
var Enemies_killed:int = 0
var current_scene
var level_one_reff = "res://scenes/Levels/model_level_1.tscn"
var level_two_reff = "res://scenes/Levels/model_level_2.tscn"
#==========================================================================================

func _ready() -> void:
	await get_tree().process_frame

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
#=====[ Enemies ]=====
	if Current_enemies <= 0:
		Current_enemies = 0
	Enemies_counter()
	Current_enemies = Max_Enemies_Num - Enemies_killed
	current_level()
	#=========================================================================================

#====> called when player dies
func Restart():
	#=====[ Restart current level & fills inventory ]=====
	get_tree().reload_current_scene()
	Current_health = Max_Health
	Current_bullets = Max_bullets
	Enemies_killed = 0

#====> calculates the number of enemies in current scene
func Enemies_counter()->void:
	Max_Enemies_Num = get_tree().get_nodes_in_group("Enemy").size()
	

#====> checks current level
func current_level():
	if level_one == true && Enemies_killed >= Max_Enemies_Num && level_two == false:
		print("Level complete")
		level_one = false
		level_two = true
		Enemies_killed = 0
		Level_switcher()


#====> switches level to level select when all enemies are killed
func Level_switcher()->void:
	get_tree().change_scene_to_file("res://scenes/Menus/level_select.tscn")
