class DRGameInfo extends SimpleGame;

defaultproperties
{
	PlayerControllerClass=class'DRPlayerController'
	DefaultPawnClass=class'DRPawn'
}

event PostLogin( PlayerController NewPlayer)
{
	super.PostLogin(NewPlayer);
	NewPlayer.ClientMessage("Welcome to the grid " $NewPlayer.PlayerReplicationInfo.PlayerName);
	NewPlayer.ClientMessage("Point at an object and press the left mouse button to retrieve the target's information");
	Spawn(class'UDKinectInstance');
}

event PlayerController Login(string Portal, string Options, const UniqueNetID UniqueID, out string ErrorMessage)
{
	local PlayerController PC;
	PC = super.Login(Portal, Options, UniqueID, ErrorMessage);
	ChangeName(PC, "Clu", true);
	
	return PC;
}