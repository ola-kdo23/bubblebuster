extends CharacterBody2D
class_name Player

@onready var animation=$AnimatedSprite2D
var speed : int=50

func ready():
	add_to_group("Player")

func _physics_process(delta: float) -> void:
	var player_move= Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity=player_move*speed
	
	if Input.is_action_pressed("ui_left"):
		$AnimatedSprite2D.play("Right_run")
	elif Input.is_action_pressed("ui_right"):
		$AnimatedSprite2D.play("Left_run")
	elif  Input.is_action_pressed("ui_up"):
		$AnimatedSprite2D.play("Back_run")
	elif Input.is_action_pressed("ui_down"):
		$AnimatedSprite2D.play("Forward_run")
	else:
		$AnimatedSprite2D.play("Idle")
		
	move_and_slide()
	
