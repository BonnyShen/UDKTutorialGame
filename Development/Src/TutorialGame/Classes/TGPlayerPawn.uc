/**
 * 游戏角色
 */
class TGPlayerPawn extends GamePawn;

var SkeletalMeshComponent HeadMesh;
var SkeletalMeshComponent HairMesh;

//动画节点
//动画列表
var AnimNodeBlendList AnimList;
//对应的动画animnodesequence
var AnimNodeSequence JumpSeq;
var AnimNodeSequence TalkSeq;
var AnimNodeSequence AttackSeq;
//动画状态
var GamePawnAnimState CurrAnimState;


//播放新的动画
function ChangeAnim(GamePawnAnimState newState) {
	local int ActiveChild;
	if (newState != PA_Walk && CurrAnimState != PA_Walk) {
		`log("当前无法播放动画,正在"@CurrAnimState);
		return;
	}
	CurrAnimState = newState;
	switch(newState) {
	case PA_Jump:
		ActiveChild = AnimList.Children.Find('Name', 'Jump');
		JumpSeq.PlayAnim(false, 1.0, 0);
		break;
	case PA_Talk:
		ActiveChild = AnimList.Children.Find('Name', 'Talk');
		JumpSeq.PlayAnim(false, 1.0, 0);
		break;
	case PA_Attack:
		ActiveChild = AnimList.Children.Find('Name', 'Attack');
		JumpSeq.PlayAnim(false, 1.0, 0);
		break;
	default:
		ActiveChild = 0;
		break;
	}
	//设置激活的索引,播放对应动画
	AnimList.SetActiveChild(ActiveChild, 0);
}

/**
 * 初始化动作树
 * @param SkelComp:角色skeletalmesh组件
 */
simulated event PostInitAnimTree(SkeletalMeshComponent SkelComp) {
	super.PostInitAnimTree(SkelComp);

	HeadMesh.SetShadowParent(Mesh);
	Mesh.AttachComponentToSocket(HeadMesh, 'HeadPoint');
	HairMesh.SetShadowParent(Mesh);
	Mesh.AttachComponentToSocket(HairMesh, 'HairPoint');

	AnimList = AnimNodeBlendList(Mesh.FindAnimNode('TGPawnAnimNodeBlendList'));
	JumpSeq = AnimNodeSequence(SkelComp.FindAnimNode('Jump'));
	TalkSeq = AnimNodeSequence(SkelComp.FindAnimNode('Talk'));
	AttackSeq = AnimNodeSequence(SkelComp.FindAnimNode('Attack00'));
	CurrAnimState = PA_Walk;
}


//动画播放结束的回调
simulated event OnAnimEnd(AnimNodeSequence SeqNode, float PlayedTime, float ExcessTime) {
	ChangeAnim(PA_Walk);
}


//动画呼叫事件
event CallScriptViaAnim() {
	`log("=== 我跳跃到了最高处啦 ===");
}

DefaultProperties
{
	Begin Object Name=CollisionCylinder
		CollisionHeight=+110.000000
		CollisionRadius=+70.000000
		BlockZeroExtent=true
	end object
	CylinderComponent=CollisionCylinder

	Begin Object class=SkeletalMeshComponent Name=MyPawnMesh
		SkeletalMesh = SkeletalMesh'Hero.Model.SK_Hero_Male_Base'
		AnimSets(0) = AnimSet'Hero.Model.Hero_Male_AnimSet'
		AnimTreeTemplate = AnimTree'Hero.Model.Hero_Male_AnimTree'
		Scale = 2
		Translation=(X=0,Y=0,Z=-110)
	End Object
	Mesh = MyPawnMesh
	components.Add(MyPawnMesh)

	begin object class=SkeletalMeshComponent Name=HdMesh
		SkeletalMesh=SkeletalMesh'Hero.Model.SK_Hero_Male_Face_Base'
	end object
	HeadMesh=HdMesh

	begin object class=SkeletalMeshComponent Name=HrMesh
		SkeletalMesh=SkeletalMesh'Hero.Model.SK_Hero_Male_Hair_01'
	end object
	HairMesh=HrMesh
}