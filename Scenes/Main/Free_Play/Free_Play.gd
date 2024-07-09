extends Control

@onready var gg_Game_Mode_Option_Button = $Setup/VBoxContainer/HBoxContainer/Game_Mode_Option_Button
@onready var gg_Ball_Count = $Mode_Setup/VBoxContainer/HBoxContainer2/Ball_Count
@onready var gg_Timer_Amount = $Mode_Setup/VBoxContainer/HBoxContainer/Timer_Amount
@onready var gg_Team_1_Count = $Mode_Setup/VBoxContainer/HBoxContainer3/Team_1_Count
@onready var gg_Team_2_Count = $Mode_Setup/VBoxContainer/HBoxContainer4/Team_2_Count
@onready var gg_Team_1_AI = $Mode_Setup/VBoxContainer/HBoxContainer5/Team_1_AI
@onready var gg_Team_2_AI = $Mode_Setup/VBoxContainer/HBoxContainer6/Team_2_AI

const GAME_MODES = {
	"Time Rush" : "res://Scenes/Main/Free_Play_Game/Free_Play_Game.tscn",
}
# Called when the node enters the scene tree for the first time.
func _ready():
	for E1 in GAME_MODES:
		gg_Game_Mode_Option_Button.add_item(E1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_pressed():

	
	var ll_Settings = ((Game_Manager.gg_Game_Setup_Template) as Dictionary).duplicate()
	ll_Settings.Mode = gg_Game_Mode_Option_Button.text
	ll_Settings.Balls = gg_Ball_Count.value
	ll_Settings.Time = gg_Timer_Amount.value
	
	ll_Settings.Team_1.Players = gg_Team_1_Count.value
	ll_Settings.Team_2.Players = gg_Team_2_Count.value
	ll_Settings.Team_1.AI = gg_Team_1_AI.button_pressed
	ll_Settings.Team_2.AI = gg_Team_2_AI.button_pressed
	if gg_Game_Mode_Option_Button.text == "Test":
		Load_Manager.Load_Scene(GAME_MODES[gg_Game_Mode_Option_Button.text])
	else:
		Load_Manager.Load_Scene(GAME_MODES[gg_Game_Mode_Option_Button.text], ll_Settings)


func _on_back_pressed():
	Load_Manager.Load_Scene_Instant("res://Scenes/Main/Menu/Menu.tscn")
