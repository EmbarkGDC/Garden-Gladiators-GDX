# Util.gd

extends Node

enum PlayerCharacter {
	ANAGO,
	BLADEZ,
	MAGURO,
	SYLKIE
}

enum SCENES {
	TITLE,
	SETTINGS,
	MINIGAME_SELECT,
	CHARACTER_SELECT,
	SUSHIDO,
	GAMEPLAY_RESULTS	
}

enum FISH {
	BLUNA,
	PALGRAM,
	SQUIPPER,
	MOONTAIL,
	HELIOUCH
}

enum CUTS {
	MISS,
	BASIC,
	PERFECT
}

enum AUDIO_BUSES {
	MASTER,
	SFX,
	SPEECH,
	MUSIC
}

var Player1Color : Color = Color(1.0, 0.792, 0.0)
var Player2Color : Color = Color(0.812, 0.0, 0.812)
var Player3Color : Color = Color(0.365, 1.0, 1.0)
var Player4Color : Color = Color(0.651, 0.0, 0.0)
