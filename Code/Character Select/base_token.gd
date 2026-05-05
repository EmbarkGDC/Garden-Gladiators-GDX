class_name PlayerBadge
extends Sprite2D

var controllerID : int
var characterID : int
var currentPort : Portrait

func getCharacter() -> void:
	currentPort = get_parent()
	currentPort.isChosen = true
	characterID = currentPort.characterID

func remove() -> void:
	currentPort.isChosen = false
	currentPort = null
