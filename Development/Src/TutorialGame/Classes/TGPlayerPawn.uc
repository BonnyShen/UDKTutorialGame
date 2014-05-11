/**
 * ��Ϸ��ɫ
 */
class TGPlayerPawn extends GamePawn;

var SkeletalMeshComponent HeadMesh;
var SkeletalMeshComponent HairMesh;

//�����ڵ�
//�����б�
var AnimNodeBlendList AnimList;
//��Ӧ�Ķ���animnodesequence
var AnimNodeSequence JumpSeq;
var AnimNodeSequence TalkSeq;
var AnimNodeSequence AttackSeq;
//����״̬
var GamePawnAnimState CurrAnimState;


//�����µĶ���
function ChangeAnim(GamePawnAnimState newState) {
	local int ActiveChild;
	if (newState != PA_Walk && CurrAnimState != PA_Walk) {
		`log("��ǰ�޷����Ŷ���,����"@CurrAnimState);
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
	//���ü��������,���Ŷ�Ӧ����
	AnimList.SetActiveChild(ActiveChild, 0);
}

/**
 * ��ʼ��������
 * @param SkelComp:��ɫskeletalmesh���
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


//�������Ž����Ļص�
simulated event OnAnimEnd(AnimNodeSequence SeqNode, float PlayedTime, float ExcessTime) {
	ChangeAnim(PA_Walk);
}


//���������¼�
event CallScriptViaAnim() {
	`log("=== ����Ծ������ߴ��� ===");
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