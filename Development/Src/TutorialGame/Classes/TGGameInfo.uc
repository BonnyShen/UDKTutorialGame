/**
 * ”Œœ∑¿‡–Õ
 */
class TGGameInfo extends GameInfo;

//game init
event PostBeginPlay() 
{
	super.PostBeginPlay();
}

DefaultProperties
{
	PlayerControllerClass=class'TutorialGame.TGPlayerController'
	DefaultPawnClass=class'TutorialGame.TGPlayerPawn'
	HUDType=class'TutorialGame.TGHud'
}
