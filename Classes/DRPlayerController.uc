class DRPlayerController extends PlayerController;

var vector HandLocation;
var DRPawn Utp;

/**
* Draw a crosshair. This function is called by the Engine.HUD class.
*/

function UpdateRotation(float DeltaTime)
{
	super.UpdateRotation(DeltaTime);
	
	/*
	local vector position;
	local int tracking_state;
	//local vector HandLocation;
	//local DRPawn Utp;
	HandLocation.Z += PlayerInput.aLookup*10+100; //giant multiplier so we extend the arm more.
	HandLocation.X += PlayerInput.aTurn*10;
	
	
	tracking_state=m_UDKinectCore.UDKinectGetSkeletonPosition(0, eUDKinectSkeletonPosition_HAND_RIGHT, position);
	`log(position.X);
	`log(position.Y);
	`log(position.Z);
	
	//ClientMessage(position.X);
	//ClientMessage(position.Y);
	//ClientMessage(position.Z);
	
	
	Utp=DRPawn(Pawn); //this simply gets our pawn so we can then point to our SkelControl
	
	
	//if((LastX>0 && PlayerInput.aTurn <0) || (LastX<0 && PlayerInput.aTurn>0)) //if we're aiming backwards with the right hand, start from tail
//		Utp.RightHandIK.bStartFromTail=true;
//	else
		//Utp.RightHandIK.bStartFromTail=false;

//	Utp.RightHandsIK.EffectorLocation=Pawn.Location + position;//Pawn.Location + HandLocation;
*/
}

function DrawHUD( HUD H)
{
	local float CrosshairSize;
	super.DrawHUD(H);
	
	H.Canvas.SetDrawColor(0,255,0,255);
	
	CrosshairSize = 4;
	H.Canvas.SetPos(H.CenterX - CrosshairSize, H.CenterY);
	H.Canvas.DrawRect(2*CrosshairSize + 1, 1);
	
	H.Canvas.SetPos(H.CenterX, H.CenterY - CrosshairSize);
	H.Canvas.DrawRect(1, 2*CrosshairSize + 1);
}

/*
* The default state for the player controller
*/

auto state PlayerWaiting
{
	exec function StartFire( optional byte FireModeNum)
	{
		showTargetInfo();
		ClientMessage("Target Fired");
	}
}

/*
* Print information about what we are looking at
*/

function showTargetInfo()
{
	local vector loc, norm, end;
	local TraceHitInfo hitInfo;
	local Actor traceHit;
	
	end = Location + normal(vector(Rotation))*32768; // trace to "infinity"
	traceHit = trace(loc, norm, end, Location, true,, hitInfo);
	
	ClientMessage("");
	
	if (traceHit == none)
	{
		ClientMessage("Nothing found, try again.");
		return;
	}
	
	// Play a sound to confirm the information
	ClientPlaySound(SoundCue'A_Vehicle_Cicada.SoundCues.A_Vehicle_Cicada_TargetLock');
	
	// By default only 4 console messages are shown at a time
	ClientMessage("Hit: "$traceHit$" class: "$traceHit.Class.Outer.Name$"."$traceHit.Class);
	ClientMessage("Location: "$loc.X$","$loc.Y$","$loc.Z);
	ClientMessage("Material: "$hitInfo.Material$" PhysMaterial: "$hitInfo.PhysMaterial);
	ClientMessage("Component: "$hitInfo.HitComponent);
}

DefaultProperties
{
	bBehindView=true
	bForceBehindView=true
	bMouseControlEnabled=true
}