extends Node2D
class_name Maze

@onready var tilemap=$TileMap

#the width and height 
var width = 37
var height = 21

#map offset for UI purposes
var offset = 2

const sourceID: int = 0

var randy= RandomNumberGenerator.new()


func _ready() -> void:
	generate_maze() #generate a map as soon as the game loads


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

## check if a cell in the tile map is empty 
func is_cell_empty(layer, coordinates):
	var data = tilemap.get_cell_tile_data(layer,coordinates)
	return data==null
		
func generate_maze():
	#declare spawn zone for the player, preferably center of the maze
	var spawnzone=[Vector2i(width/2-offset,height/2),
	Vector2(width/2-offset,height/2+1), Vector2i(width/2-offset,height/2+offset)]
	
	#create the exterior walls
	for x in range(width):
		for y in range(height):
			if x==0 or x==width -1 or y==0 or y ==height -1:
				tilemap.set_cell(1,Vector2i(x, y + offset),sourceID,Vector2i(6,0),0)
				
				
	#create the random walls inside the room
	for x in range(1,width-2):
		for y in range(1, height-2):
			if x%2==0 and y%2==0:   #create a wal at every other cell
				tilemap.set_cell(1,Vector2i(x,y+offset),sourceID,Vector2i(6,0),0)
	

	for x in range(1,width-1):  
		for y in range(1,height-1):
			var wall_chance=0.2
			var b=randy.randf_range(-0.12,0.36)
			var current_cell = Vector2i(x,y+offset)
			var skip_cell=false
			
			#if youre at a cell or at the center of the maze skip those cells
			if x%2 ==0 and y %2 ==0:
				skip_cell=true
			for center in spawnzone:
				if current_cell.x==center.x && current_cell.y==center.y:
					skip_cell=true
					break
			if skip_cell:
				continue
				
			#when at an empty cell decide to add a tile or not
			if is_cell_empty(1, current_cell):
				print("yupe")
				if randy.randf() < b:
					tilemap.set_cell(1,current_cell,0,Vector2i(6,0),0)
		  
			
		#create the background
