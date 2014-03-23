/**
 * ������Ϸ��������ӽ�
 */
class TGCamera extends GamePlayerCamera;

/**ˮƽ�Ƕ�*/
var float hor_angle;
/**��ֱ�Ƕ�*/
var float ver_angle;
/**������ľ���*/
var float distance;


/**
 * ���������
 * @param OutVT:������ӽ�
 * @param DeltaTime:���¼��
 */
function UpdateViewTarget(out TViewTarget OutVT, float DeltaTime)
{
	local Vector Loc, PawnLoc;
	local Rotator Rot;
	
	//�������ڵ�����
	PawnLoc = Pawn(OutVT.Target).Location;

	//�����������λ��
	Loc.X = PawnLoc.X - distance;
	Loc.Y = PawnLoc.Y - distance * tan(hor_angle*DegToRad);
	Loc.Z = PawnLoc.Z + distance/(cos(hor_angle*DegToRad)) * tan(ver_angle*DegToRad);      //����λ��

	//���������ת�Ƕ�
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
