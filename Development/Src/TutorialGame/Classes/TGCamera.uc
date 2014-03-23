/**
 * 我们游戏的摄像机视角
 */
class TGCamera extends GamePlayerCamera;

/**水平角度*/
var float hor_angle;
/**垂直角度*/
var float ver_angle;
/**摄像机的距离*/
var float distance;


/**
 * 更新摄像机
 * @param OutVT:输出的视角
 * @param DeltaTime:更新间隔
 */
function UpdateViewTarget(out TViewTarget OutVT, float DeltaTime)
{
	local Vector Loc, PawnLoc;
	local Rotator Rot;
	
	//人物所在的坐标
	PawnLoc = Pawn(OutVT.Target).Location;

	//摄像机的坐标位置
	Loc.X = PawnLoc.X - distance;
	Loc.Y = PawnLoc.Y - distance * tan(hor_angle*DegToRad);
	Loc.Z = PawnLoc.Z + distance/(cos(hor_angle*DegToRad)) * tan(ver_angle*DegToRad);      //距离位置

	//摄像机的旋转角度
	Rot.Pitch = -1*ver_angle*180;
	Rot.Roll = 0;
	Rot.Yaw = hor_angle*180;

	OutVT.POV.Location = Loc;
	OutVT.POV.Rotation = Rot;

	OutVT.POV.FOV = 65;
	`log("== update camera at location "@Loc@" and rotation"@Rot);
}

DefaultProperties
{
	distance = 618
	ver_angle = 50
	hor_angle = 45
}
