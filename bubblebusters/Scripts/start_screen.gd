extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.show()
	get_tree().paused=true
	
func _on_play_pressed() -> void:
	get_tree().paused=false
	self.hide()
