extends CanvasLayer


func _ready() -> void:
	self.hide()  #hide when you first get into the scene
	
	
func _on_button_pressed() -> void:
	print("here")
	get_tree().paused=false   #so that the game continues playing after you hit retry
	get_tree().reload_current_scene()
	
func end_game()-> void:
	get_tree().paused=true
	self.show()  #so show when the game ends
	
