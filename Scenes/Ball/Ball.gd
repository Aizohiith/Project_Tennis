extends RigidBody2D
@onready var gg_Bounce_Audio_Player = $Bounce_Audio_Player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_sound_area_area_entered(area):
	Game_Manager.gg_Screen_Shake.emit(1)
	gg_Bounce_Audio_Player.pitch_scale = randf_range(-0.1, 0.1) + 1
	gg_Bounce_Audio_Player.volume_db = linear_to_db(linear_velocity.length() / 100)
	gg_Bounce_Audio_Player.play()
