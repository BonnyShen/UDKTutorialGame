/**
 * 角色控制
 */
class TGPlayerController extends GamePlayerController;

//垂直输入
var input float aVertical;
//水平输入
var input float aHorizontal;

//人物状态
var GamePawnState currState;//当前状态
var GamePawnState lastState;//上一次状态


/**
 * 初始化
 */
simulated function PostBeginPlay() {
	super.PostBeginPlay();
	self.currState = PS_None;
	self.lastState = PS_None;
	ChangeState(PS_Walk);
}


/**
 * 切换到一个新状态
 */
function ChangeState(GamePawnState newState) {
	if (currState != newState) {
		self.lastState = currState;
		self.currState = newState;
		`log("state was changed from "@lastState@" to "@currState);
		switch(self.currState) {//根据状态进行跳转
		case PS_None:
			break;
		case PS_Walk:
			GotoState('PlayerWalking');
			break;
		}
	}
}


/**
 * 人物行走状态
 */
state PlayerWalking {
	//进入状态
	simulated event BeginState(name PreviousStateName)
	{
		super.BeginState(PreviousStateName);
	}

	//离开状态
	simulated event EndState(name NextStateName)
	{
		super.EndState(NextStateName);
	}

	function ProcessMove(float DeltaTime, vector NewAccel, eDoubleClickDir DoubleClickMove, rotator DeltaRot) {
		//super.ProcessMove(DeltaTime, NewAccel, DoubleClickMove, DeltaRot);
		if( Pawn == None ) {
			return;
		}

		if (Role == ROLE_Authority) {
			Pawn.SetRemoteViewPitch(Rotation.Pitch);
		}

		Pawn.Acceleration = NewAccel;
		Pawn.Velocity.X = NewAccel.X;
		Pawn.Velocity.Y = NewAccel.Y;
	}

	/**
	 * 玩家移动
	 */
	function PlayerMove(float DeltaTime)
	{
		local Vector NewAccel;
		if (Pawn == None)
		{
			`log("no pawn was found something wrong !");
		}
		else if (Pawn.CustomTimeDilation == 0)
		{
			`log("pawns custom time dilation was set to zero !");
		}
		else
		{
			if(aVertical == 0 && aHorizontal == 0)
			{
				NewAccel = vect(0,0,0);
			}
			else
			{
				UpdatePawnRotation();
				NewAccel.X = Cos(Pawn.Rotation.Yaw * UnrRotToRad) * Pawn.GroundSpeed;
				NewAccel.Y = Sin(Pawn.Rotation.Yaw * UnrRotToRad) * Pawn.GroundSpeed;
				
				aVertical = 0;
				aHorizontal = 0;
			}

			// use default settings, just for net move
			if (Role < ROLE_Authority)
			{
				ReplicateMove(DeltaTime, NewAccel, DCLICK_None, rot(0,0,0));
			}
			else
			{
				ProcessMove(DeltaTime, NewAccel, DCLICK_None, rot(0,0,0));
			}
		}
	}
}

/**更新玩家方向*/
simulated function UpdatePawnRotation() {
	local Rotator viewRotation;
	local float rot;

	viewRotation = Pawn.Rotation;

	if (Pawn != none)
	{
		Pawn.SetDesiredRotation(ViewRotation);
	}

	if (aVertical == 0 && aHorizontal == 0)
	{
		return;
	}
	else if (aVertical == 0 && aHorizontal != 0)
	{
		if (aHorizontal > 0)
		{
			rot = 90;
		}
		else
		{
			rot = 270;
		}
	}
	else
	{
		rot = Atan(aHorizontal/aVertical) * RadToDeg;
		if (aVertical < 0)
		{
			rot += 180;
		}
		
	}

	rot += 45;
	viewRotation.Yaw = rot * DegToUnrRot;
	
	if (Pawn != none) {
		Pawn.SetRotation(viewRotation);
	}
}


exec function HelloJ() {
	`log("J was pressed");
	TGPlayerPawn(Pawn).ChangeAnim(PA_Jump);
}

exec function HelloK() {
	`log("K was pressed --- ");
	TGPlayerPawn(Pawn).ChangeAnim(PA_Talk);
}

exec function HelloL(int param) {
	`log("L was pressed " @param);
	TGPlayerPawn(Pawn).ChangeAnim(PA_Attack);
}

DefaultProperties
{
	CameraClass=class'TutorialGame.TGCamera'
}
