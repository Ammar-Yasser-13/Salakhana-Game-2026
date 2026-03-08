extends CanvasLayer

#===============[UI Reffrences]===============
@onready var health_bar: AnimatedSprite2D = $"Health bar"
@onready var enemy_symbol: Sprite2D = $"Enemy symbol"
@onready var bullet_1: Sprite2D = $Bullet1
@onready var bullet_2: Sprite2D = $Bullet2
@onready var bullet_3: Sprite2D = $Bullet3
@onready var bullet_4: Sprite2D = $Bullet4
@onready var bullet_5: Sprite2D = $Bullet5
@onready var bullet_6: Sprite2D = $Bullet6
@onready var enemy_counter: Label = $"Enemy counter"
#=============================================

func _process(_delta: float) -> void:
#===============[Player's Health]===============
	if Game_Manger.Current_health <= 4:
		health_bar.frame = 4
	if Game_Manger.Current_health <= 3:
		health_bar.frame = 3
	if Game_Manger.Current_health <= 2:
		health_bar.frame = 2
	if Game_Manger.Current_health <= 1:
		health_bar.frame = 1
	if Game_Manger.Current_health <= 0:
		health_bar.frame = 0
#===============[Player's bullets]===============
	if Game_Manger.Current_bullets <= 6:
		bullet_1.visible = true
		bullet_2.visible = true
		bullet_3.visible = true
		bullet_4.visible = true
		bullet_5.visible = true
		bullet_6.visible = true
	if Game_Manger.Current_bullets <= 5:
		bullet_1.visible = true
		bullet_2.visible = true
		bullet_3.visible = true
		bullet_4.visible = true
		bullet_5.visible = true
		bullet_6.visible = false
	if Game_Manger.Current_bullets <= 4:
		bullet_1.visible = true
		bullet_2.visible = true
		bullet_3.visible = true
		bullet_4.visible = true
		bullet_5.visible = false
		bullet_6.visible = false
	if Game_Manger.Current_bullets <= 3:
		bullet_1.visible = true
		bullet_2.visible = true
		bullet_3.visible = true
		bullet_4.visible = false
		bullet_5.visible = false
		bullet_6.visible = false
	if Game_Manger.Current_bullets <= 2:
		bullet_1.visible = true
		bullet_2.visible = true
		bullet_3.visible = false
		bullet_4.visible = false
		bullet_5.visible = false
		bullet_6.visible = false
	if Game_Manger.Current_bullets <= 1:
		bullet_1.visible = true
		bullet_2.visible = false
		bullet_3.visible = false
		bullet_4.visible = false
		bullet_5.visible = false
		bullet_6.visible = false
	if Game_Manger.Current_bullets <= 0:
		bullet_1.visible = false
		bullet_2.visible = false
		bullet_3.visible = false
		bullet_4.visible = false
		bullet_5.visible = false
		bullet_6.visible = false
