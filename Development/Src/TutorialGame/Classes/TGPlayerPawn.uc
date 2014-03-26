/**
 * сно╥╫ги╚
 */
class TGPlayerPawn extends GamePawn;

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
}