extends Area2D

var gi_Ball_Count : int = 0	
	
func Ball_Count():
	return gi_Ball_Count

func _on_area_entered(area):
	gi_Ball_Count += 1


func _on_area_exited(area):
	gi_Ball_Count -= 1
