extends Area2D
@onready var soundEffect=$PopSound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	



func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		soundEffect.play()  #frees queue before sounding outloud
		#increment score and disappear
		Global.score+=1
		queue_free()
