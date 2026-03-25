extends Node

#==================================[ Player Stats ]========================================
const Max_Health = 4
const Max_bullets = 6
const Min_Health = 0
const Min_bullets = 0
var Enemies_level_counter = 0
@export var Current_health:int = Max_Health 
@export var Current_bullets:int = Max_bullets
@export var Current_enemies:int = Enemies_level_counter
#============================================================================================
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
	#=========================================================================================
func Restart():
	#=====[ Restart current level & fills inventory ]=====
	get_tree().reload_current_scene()
	Current_health = Max_Health
	Current_bullets = Max_bullets
