/**
 * ��ɫ����
 */
class TGPlayerController extends GamePlayerController;

//��ֱ����
var input float aVertical;
//ˮƽ����
var input float aHorizontal;

simulated function PostBeginPlay() {
	super.PostBeginPlay();
}

exec function HelloJ() {
	`log("J was pressed");
}

exec function HelloK() {
	`log("K was pressed --- ");
}

exec function HelloNotK() {
	`log("K was released === ");
}

exec function HelloL(int param) {
	`log("L was pressed " @param);
}


DefaultProperties
{
	CameraClass=class'TutorialGame.TGCamera'
}
