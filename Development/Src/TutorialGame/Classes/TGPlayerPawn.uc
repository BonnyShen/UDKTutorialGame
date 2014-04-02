/**
 * 游戏角色
 */
class TGPlayerPawn extends GamePawn;

var SkeletalMeshComponent HeadMesh;
var SkeletalMeshComponent HairMesh;

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