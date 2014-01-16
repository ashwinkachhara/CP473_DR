class DRPawn extends Pawn;

/*var SkelControl_CCD_IK RightHandsIK;

simulated event PostInitAnimTree(SkeletalMeshComponent SkelComp)
{
	super.PostInitAnimTree(SkelComp);
	RightHandsIK = SkelControl_CCD_IK( mesh.FindSkelControl('RightArmIK') );
}
*/
defaultproperties
{
	Begin Object class=SkeletalMeshComponent Name=SkeletalMeshComponent0
		SkeletalMesh=SkeletalMesh'ch_ironguard_male_mymale.Mesh.SK_CH_IronGuard_MaleA_MyMale'
		bAcceptsLights=true
		EndObject
	Mesh=SkeletalMeshComponent0
	Components.AddItem(SkeletalMeshComponent0)
	//Begin Object Name=WPawnSkeletalMeshComponent
	//AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree_MyTree.AT_CH_Human_MyTree'
	//End Object
}
