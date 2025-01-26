extends Node2D
class_name Maze

@onready var tilemap=$TileMap
@onready var player = $Player
@onready var music=$Music
@onready var timer=$Timer
@onready var timer_label=$TimerLabel
@onready var results =$Results
var bubblePath = preload("res://Scenes/bubble.tscn")


#map width and height 
var width = 35
var height = 21

const sourceID: int = 0
var randy= RandomNumberGenerator.new()
var bubbleCount : int
var time_len = 10

func _ready() -> void:
	generate_maze() #generate a map as soon as the game loads
	
	print(bubbleCount)
	timer.start()
	timer.connect("timeout", Callable(self, "_on_game_timer_timeout"))
	update_timer()
	update_timer_label()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

## check if a cell in the tile map is empty 
func is_cell_empty(layer, coordinates):
	var data = tilemap.get_cell_tile_data(layer,coordinates)
	return data==null
		
func generate_maze():
	#create the exterior walls
	for x in range(width):
		for y in range(height):
			if x==0 or x==width -1 or y==0 or y ==height -1:
				tilemap.set_cell(1,Vector2i(x, y ),sourceID,Vector2i(6,0),0)
				
				
	#create the random walls inside the room
	for x in range(1,width-2):
		for y in range(1, height-2):
			if x%2==0 and y%2==0:   #create a wal at every other cell
				#pass
				tilemap.set_cell(1,Vector2i(x,y),sourceID,Vector2i(6,0),0)
	

	for x in range(1,width-1):  
		for y in range(1,height-1):
			var wall_chance=0.2
			var b=randy.randf_range(-0.12,0.36)
			var current_cell = Vector2i(x,y)
			var skip_cell=false
			
			#if youre at a cell or at the center of the maze skip those cells
			if x%2 ==0 and y %2 ==0:
				skip_cell=true
			
			if current_cell.x==120 && current_cell.y==120:
				skip_cell=true
				break
			if skip_cell:
				continue
				
			#when at an empty cell decide to add a tile or not
			if is_cell_empty(1, current_cell):
				if randy.randf() < b:
					tilemap.set_cell(1,current_cell,sourceID,Vector2i(6,0),0)
	
	#create the background
	for x in range(1, width-1):
		for y in range(1, height-1):
			var curent_tile = Vector2i(x,y)
			if(is_cell_empty(1,curent_tile))	:
				tilemap.set_cell(0,curent_tile,sourceID,Vector2i(0,7),0)
				
			
				if randy.randf_range(0,1) < 0.12 && (curent_tile.x!=120 && curent_tile.y!=120):
					print("hello")
					var b= bubblePath.instantiate()
					b.position= Vector2i((x*16)+8,(y*16)+8)
					add_child(b)
					bubbleCount+=1
				
	callPlayer()
	

func callPlayer():
	player.position=Vector2i(120,120)
	
func _on_timer_timeout() -> void:
	print("Game over!")
	
func update_timer_label()-> void:
	timer_label.text = "Time Left: " + str(time_len) + "s"
	
func update_timer()-> void:
	while time_len>0:
		update_timer_label()
		await get_tree().create_timer(1).timeout
		time_len-=1
		
	if(time_len==0):
		showresults()

func showresults()-> void:
	$EndScreen/EndResults.text="you got " + str(Global.score) + " / " + str(bubbleCount) + "bubbles!!"
	$EndScreen.end_game()
