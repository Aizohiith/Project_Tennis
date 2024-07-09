extends Node

var gs_App_ID = "3097880"

signal gg_Screen_Shake


var gg_Team_Setup_Template = {
	"Color" : 0,
	"Players" : 0,
	"AI" : false
}
var gg_Game_Setup_Template = {
		"Mode" : "",
		"Balls" : 0,
		"Time" : 0,
		"Team_1" : gg_Team_Setup_Template.duplicate(),
		"Team_2" : gg_Team_Setup_Template.duplicate(),
	}
	
func _init():
	OS.set_environment("SteanAppID", gs_App_ID)
	OS.set_environment("SteamGameID", gs_App_ID)
	
func _process(delta):
	Steam.run_callbacks()

func _ready():
	var ll_Init = Steam.steamInit()
	var lb_Steam_Running = Steam.isSteamRunning()
	print(ll_Init)
	print(lb_Steam_Running)
	print(Steam.getAchievementName(0))
	print(Steam.getAchievement("TEST"))


	
func Generate_Random_2D_Vector():
	var lf_X = randf_range(-1.0, 1.0)
	var lf_Y = randf_range(-1.0, 1.0)
	return Vector2(lf_X, lf_Y)
	
func Generate_Normal_Distributed_Float(lf_Mean: float = 0.0, lf_STD: float = 1.0) -> float:
	var lf_U1 = randf()
	var lf_U2 = randf()
	var lf_Z = sqrt(-2.0 * log(lf_U1)) * cos(2.0 * PI * lf_U2)
	return lf_Z * lf_STD + lf_Mean

func Clear_Achievement(ps_Name):
	Steam.clearAchievement(ps_Name)
	Steam.storeStats()

func Set_Achievement(ps_Name):
	Steam.setAchievement(ps_Name)
	Steam.storeStats()
