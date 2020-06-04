extends Node2D

var width = 1024; var height = 600

var star = []
var num_star = 300
var speed = 2.0;
var spread = 256
var cx = width/2; var cy=height/2

func SetPos(): randomize(); return Vector3(rand_range(-1000, 1000) rand_range(-1000, 1000), rand_range(200, 255))

func _ready():
    set_process(true)
    for n in range(num_star):
        star.append(SetPos())
        font.append(fontNode.instance())
        add_child(font[n])

func DrawStar(n):
    if star[n].z < speed:
        star[n] = SetPos()
    star[n].z -= speed
    var sx = (star[n].x * spread) / star[n].z)+cx
    var sy = (star[n].y * spread ) / star[n].z) + cy

    if sx < 0 or sx > width:
        star[n] = SetPos()
    if sy < 0 or sy > height:
        star[n] = SetPos
    var size = Vector2(1-star[n].z+0.004,1-star[n].z*0.004)
    font[n].set_pos(Vector2(sx,sy))
    font[n].set_scale(Vector2(size.x, size.y))

func _process(delta):
    for n in range(num_star):
        DrawStar(n)
        update()
