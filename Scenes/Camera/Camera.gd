extends Camera2D


const SHAKE_FADE = 5

var gf_Shake_Strength = 0

func _ready():
	Game_Manager.gg_Screen_Shake.connect(Shake)
	
func Shake(pf_Amount):
	gf_Shake_Strength = pf_Amount
	
func _process(delta):
	
	if (gf_Shake_Strength > 0):
		gf_Shake_Strength = lerpf(gf_Shake_Strength, 0, SHAKE_FADE * delta)
	
	offset = Random_Shake()

func Random_Shake() -> Vector2:
	return Vector2(randf_range(-gf_Shake_Strength,gf_Shake_Strength), randf_range(-gf_Shake_Strength,gf_Shake_Strength))
