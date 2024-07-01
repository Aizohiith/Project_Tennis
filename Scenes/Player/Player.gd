extends RigidBody2D

@export var gb_AI = false
@export var gf_AI_Shoot_Interval_Mean : float = 1.5
@export var gf_AI_Shoot_Interval_STD : float = 1.0

var gb_Hold : bool = false
var gf_Time_Since_Last_Shoot : float = 0
var gf_AI_Shoot_Interval : float = 0
var gb_Hit_Ball : bool = false

@onready var gg_Player_CDark = $Sprites/PlayerCDark
@onready var gg_Player_CLight = $Sprites/PlayerCLight
@onready var gg_Player_Eye_Outer = $Sprites/PlayerEyeOuter
@onready var gg_Player_Base = $Sprites/Base
@onready var gg_Hit_Audio_Player = $Hit_Audio_Player
@onready var gg_Shoot_Audio_Player = $Shoot_Audio_Player
@onready var gg_Bounce_Audio_Player = $Bounce_Audio_Player
@onready var gg_Sprite_Arrow = $Sprite_Arrow

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	gf_Time_Since_Last_Shoot += delta
	if (gf_Time_Since_Last_Shoot > 0.5):
		gb_Hit_Ball = false
	gg_Sprite_Arrow.visible = gb_Hold
	if gb_Hold:
		var lv2_Dir = get_global_mouse_position() - global_position
		var lf_Shoot_Power = lv2_Dir.length() * 100
		lf_Shoot_Power = clamp(lf_Shoot_Power, 100, 10000)
		gg_Sprite_Arrow.scale.x = lf_Shoot_Power/1000
	Human_Rotate()
	Human_Shoot()
	AI_Shoot()

func _input_event(viewport, event, shape_idx):
	if gb_AI:
		return
	if event.is_action_pressed("Hold"):
		gb_Hold = true
		
func Human_Rotate():
	if gb_AI:
		return
	if not gb_Hold:
		return
	look_at(get_global_mouse_position())
	
func AI_Shoot():
	if not gb_AI:
		return
	if (gf_Time_Since_Last_Shoot > gf_AI_Shoot_Interval):
		gf_AI_Shoot_Interval = Game_Manager.Generate_Normal_Distributed_Float(gf_AI_Shoot_Interval_Mean, gf_AI_Shoot_Interval_STD)
		var lv2_Dir = Game_Manager.Generate_Random_2D_Vector() * randf_range(0, 1)
		look_at(lv2_Dir)
		Shoot(lv2_Dir)
	
func Human_Shoot():
	if gb_AI:
		return
	if not Input.is_action_just_released("Hold"):
		return
	if not gb_Hold:
		return
	gb_Hold = false
	Shoot(get_global_mouse_position())
	
func Shoot(gv2_Dir_Power : Vector2):
	gf_Time_Since_Last_Shoot = 0
	
	gb_Hit_Ball = true
	var lv2_Dir = gv2_Dir_Power - global_position
	var lf_Shoot_Power = lv2_Dir.length() * 100
	lf_Shoot_Power = clamp(lf_Shoot_Power, 100, 10000)
	lv2_Dir = -lv2_Dir.normalized()
	apply_central_force(lv2_Dir * lf_Shoot_Power)
	gg_Shoot_Audio_Player.pitch_scale = randf_range(-0.2, 0.1) + 1
	gg_Shoot_Audio_Player.volume_db = linear_to_db(lf_Shoot_Power / 10000)
	gg_Shoot_Audio_Player.play()

func Set_Color(lf_Hue : float):
	var ll_Base = Color.from_hsv(lf_Hue, 1, 0.6)
	var ll_Eyes = Color.from_hsv(lf_Hue,  0.2, 0.95)
	var ll_Light = Color.from_hsv(lf_Hue, 0.9, 0.7)
	var ll_Dark = Color.from_hsv(lf_Hue, 0.9, 1)
	
	gg_Player_Base.self_modulate = ll_Base
	gg_Player_CDark.self_modulate = ll_Dark
	gg_Player_CLight.self_modulate = ll_Light
	gg_Player_Eye_Outer.self_modulate = ll_Eyes


func _on_sound_area_area_entered(area):
	if area.get_parent().is_in_group("Ball"):
		if not gb_Hit_Ball:
			return
		Game_Manager.gg_Screen_Shake.emit(10)
		gg_Hit_Audio_Player.volume_db = linear_to_db(linear_velocity.length() / 500)
		gg_Hit_Audio_Player.play()
		gb_Hit_Ball = false
	if area.get_parent().is_in_group("Player") or area.is_in_group("Sound_Area"):
		Game_Manager.gg_Screen_Shake.emit(2)
		gg_Bounce_Audio_Player.volume_db = linear_to_db(linear_velocity.length() / 250)
		gg_Bounce_Audio_Player.play()
