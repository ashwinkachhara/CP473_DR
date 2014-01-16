//-----------------------------------------------------------
// 
// UDKinectInstance.uc 
//
// Copyright (c) 2012 UDKinect, Charlie Hodara
//
// This file is released under the MIT License.
//
// Permission is hereby granted, free of charge, to any person obtaining 
// a copy of this software and associated documentation files (the "Software"), 
// to deal in the Software without restriction, including without limitation 
// the rights to use, copy, modify, merge, publish, distribute, sublicense, 
// and/or sell copies of the Software, and to permit persons to whom the 
// Software is furnished to do so, subject to the following conditions: 
// The above copyright notice and this permission notice shall be 
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR 
// ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF 
// CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION 
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 
//
//-----------------------------------------------------------

class UDKinectInstance extends Actor; 

//-----------------------------------------------------------
// variables
//-----------------------------------------------------------

var private UDKinectCore m_UDKinectCore;

//-----------------------------------------------------------
// Init / ShutDown
//-----------------------------------------------------------

function private bool UDKinectInitialize( eUDKinectUserTrackingStyle userTrackingStyle, eUDKinectSkeletonSmoothing skeletonSmoothing )
{
	return m_UDKinectCore.UDKinectInitialize( userTrackingStyle, skeletonSmoothing );
}

function private UDKinectShutDown()
{
	m_UDKinectCore.UDKinectShutDown();
}

//-----------------------------------------------------------
// Nui
//-----------------------------------------------------------

function bool UDKinectIsSensorReady()
{
	return m_UDKinectCore.UDKinectIsSensorReady();
}

function UDKinectSetCameraElevationAngle( int elevation )
{
	m_UDKinectCore.UDKinectSetCameraElevationAngle( elevation );
}

function int UDKinectGetCameraElevationAngle()
{
	return m_UDKinectCore.UDKinectGetCameraElevationAngle();
}

function UDKinectSetSkeletonSmoothing( eUDKinectSkeletonSmoothing smoothingStyle )
{
	m_UDKinectCore.UDKinectSetSkeletonSmoothing( smoothingStyle );
}

function eUDKinectSkeletonTrackingState UDKinectGetSkeletonTrackingState( int userIndex, eUDKinectSkeletonPosition boneId )
{
	return eUDKinectSkeletonTrackingState( m_UDKinectCore.UDKinectGetSkeletonTrackingState( userIndex, boneId ) );
}

function UDKinectGetSkeletonPosition( int userIndex, eUDKinectSkeletonPosition boneId, out Vector bonePosition )
{
	m_UDKinectCore.UDKinectGetSkeletonPosition( userIndex, boneId, bonePosition );
}

function UDKinectGetSkeletonPositionTransformedToDepthImage( int userIndex, eUDKinectSkeletonPosition boneId, out Vector2D bonePosition )
{
	m_UDKinectCore.UDKinectGetSkeletonPositionTransformedToDepthImage( userIndex, boneId, bonePosition );
}

function bool UDKinectGetImageStream( eUDKinectImageType imageType, out UDKinectFrame frame )
{
	return m_UDKinectCore.UDKinectGetImageStream( imageType, frame );
}

function UDKinectTransformDepthImageToSkeleton( out Vector2D depthCoord, out Vector outCoord, int depthValue )
{
	m_UDKinectCore.UDKinectTransformDepthImageToSkeleton( depthCoord, outCoord, depthValue );
}

function UDKinectTransformSkeletonToDepthImage( out Vector skelCoord, out Vector2D outCoord2D )
{
	m_UDKinectCore.UDKinectTransformSkeletonToDepthImage( skelCoord, outCoord2D );
}

//-----------------------------------------------------------
// User
//-----------------------------------------------------------

// userIndex: 0 --> player 1, 1 --> player 2 (2 users max --> number limit of skeletons tracked by the kinect sdk)
function bool UDKinectIsUserReady( int userIndex )
{
	return m_UDKinectCore.UDKinectIsUserReady( userIndex );
}

function int UDKinectGetNbUserReady()
{
	return m_UDKinectCore.UDKinectGetNbUserReady();
}

function UDKinectSetUserTrackingStyle( eUDKinectUserTrackingStyle userTrackingStyle )
{
	m_UDKinectCore.UDKinectSetUserTrackingStyle( userTrackingStyle );
}

//-----------------------------------------------------------
// Preview window
//-----------------------------------------------------------

function UDKinectShowPreviewWindow( eUDKinectImageType imageType )
{
	m_UDKinectCore.UDKinectShowPreviewWindow( imageType );
}

function UDKinectHidePreviewWindow( eUDKinectImageType imageType )
{
	m_UDKinectCore.UDKinectHidePreviewWindow( imageType );
}

function UDKinectShowPreviewWindows()
{
	m_UDKinectCore.UDKinectShowPreviewWindows();
}

function UDKinectHidePreviewWindows()
{
	m_UDKinectCore.UDKinectHidePreviewWindows();
}

//-----------------------------------------------------------
// Methods
//-----------------------------------------------------------

//-----------------------------------------------------------
event PostBeginPlay()
{
	super.PostBeginPlay();
	
	if( UDKinectInitialize( eUDKinectUserTrackingStyle_QUEUE, eUDKinectSkeletonSmoothing_FAST_LOW_LATENCY ) )
		`log( "[UDKinect] Initialized" );
	else
		`log( "[UDKinect] Initialization failed. Is Kinect pluged-in? / are you using udk 64 bit? (32 bit compatible only)" );
}

//-----------------------------------------------------------
event Destroyed()
{
	super.Destroyed();

	UDKinectShutDown();
	`log( "[UDKinect] Deinitialized" );
}

//-----------------------------------------------------------
function DrawDebugSkeletons( HUD H, Color ColorSkel1=MakeColor(255,0,0), Color ColorSkel2=MakeColor(0,0,255), Color ColorFrame=MakeColor(255,0,0), float Scale=1.0f, Vector2D OffsetScreen=Vect2D(25.0f, 25.0f) )
{
	H.Canvas.SetDrawColor( 255, 0, 0 );
	H.Canvas.SetPos( 25.0f, 25.0f, 0.0f );

	if( UDKinectGetNbUserReady() < 1 )
		return;

	H.Canvas.Draw2DLine( OffsetScreen.X, OffsetScreen.Y, OffsetScreen.X+320.0f*Scale, OffsetScreen.Y, ColorFrame );
	H.Canvas.Draw2DLine( OffsetScreen.X+320.0f*Scale, OffsetScreen.Y, OffsetScreen.X+320.0f*Scale, OffsetScreen.Y+240.0f*Scale, ColorFrame );
	H.Canvas.Draw2DLine( OffsetScreen.X, OffsetScreen.Y, OffsetScreen.X, OffsetScreen.Y+240.0f*Scale, ColorFrame );
	H.Canvas.Draw2DLine( OffsetScreen.X, OffsetScreen.Y+240.0f*Scale, OffsetScreen.X + 320.0f*Scale, OffsetScreen.Y+240.0f*Scale, ColorFrame );

	DrawSkeleton( H, 0, ColorSkel1, Scale, OffsetScreen );
	DrawSkeleton( H, 1, ColorSkel2, Scale, OffsetScreen );
}

//-----------------------------------------------------------
private function DrawSkeleton( HUD H, int User, Color ColorSkel, float Scale, Vector2D OffsetScreen )
{
	local Array<Vector2D> bones_depth;
	local Vector2D bone_loc_2d;
	local int i;

	if( !UDKinectIsUserReady(User) )
		return;

	for( i=0; i<eUDKinectSkeletonPosition_COUNT; ++i )
	{
		UDKinectGetSkeletonPositionTransformedToDepthImage( User, eUDKinectSkeletonPosition(i), bone_loc_2d );
	
		bone_loc_2d *= Scale;
		bone_loc_2d += OffsetScreen;

		bones_depth.AddItem( bone_loc_2d );
	}

	DrawSkeletonSegment( H, bones_depth[eUDKinectSkeletonPosition_HIP_CENTER], bones_depth[eUDKinectSkeletonPosition_SPINE], ColorSkel );
	DrawSkeletonSegment( H, bones_depth[eUDKinectSkeletonPosition_SPINE], bones_depth[eUDKinectSkeletonPosition_SHOULDER_CENTER], ColorSkel );
	DrawSkeletonSegment( H, bones_depth[eUDKinectSkeletonPosition_SHOULDER_CENTER], bones_depth[eUDKinectSkeletonPosition_HEAD], ColorSkel );

	DrawSkeletonSegment( H, bones_depth[eUDKinectSkeletonPosition_SHOULDER_CENTER], bones_depth[eUDKinectSkeletonPosition_SHOULDER_LEFT], ColorSkel );
	DrawSkeletonSegment( H, bones_depth[eUDKinectSkeletonPosition_SHOULDER_LEFT], bones_depth[eUDKinectSkeletonPosition_ELBOW_LEFT], ColorSkel );
	DrawSkeletonSegment( H, bones_depth[eUDKinectSkeletonPosition_ELBOW_LEFT], bones_depth[eUDKinectSkeletonPosition_WRIST_LEFT], ColorSkel );
	DrawSkeletonSegment( H, bones_depth[eUDKinectSkeletonPosition_WRIST_LEFT], bones_depth[eUDKinectSkeletonPosition_HAND_LEFT], ColorSkel );

	DrawSkeletonSegment( H, bones_depth[eUDKinectSkeletonPosition_SHOULDER_CENTER], bones_depth[eUDKinectSkeletonPosition_SHOULDER_RIGHT], ColorSkel );
	DrawSkeletonSegment( H, bones_depth[eUDKinectSkeletonPosition_SHOULDER_RIGHT], bones_depth[eUDKinectSkeletonPosition_ELBOW_RIGHT], ColorSkel );
	DrawSkeletonSegment( H, bones_depth[eUDKinectSkeletonPosition_ELBOW_RIGHT], bones_depth[eUDKinectSkeletonPosition_WRIST_RIGHT], ColorSkel );
	DrawSkeletonSegment( H, bones_depth[eUDKinectSkeletonPosition_WRIST_RIGHT], bones_depth[eUDKinectSkeletonPosition_HAND_RIGHT], ColorSkel );

	DrawSkeletonSegment( H, bones_depth[eUDKinectSkeletonPosition_HIP_CENTER], bones_depth[eUDKinectSkeletonPosition_HIP_LEFT], ColorSkel );
	DrawSkeletonSegment( H, bones_depth[eUDKinectSkeletonPosition_HIP_LEFT], bones_depth[eUDKinectSkeletonPosition_KNEE_LEFT], ColorSkel );
	DrawSkeletonSegment( H, bones_depth[eUDKinectSkeletonPosition_KNEE_LEFT], bones_depth[eUDKinectSkeletonPosition_ANKLE_LEFT], ColorSkel );
	DrawSkeletonSegment( H, bones_depth[eUDKinectSkeletonPosition_ANKLE_LEFT], bones_depth[eUDKinectSkeletonPosition_FOOT_LEFT], ColorSkel );

	DrawSkeletonSegment( H, bones_depth[eUDKinectSkeletonPosition_HIP_CENTER], bones_depth[eUDKinectSkeletonPosition_HIP_RIGHT], ColorSkel );
	DrawSkeletonSegment( H, bones_depth[eUDKinectSkeletonPosition_HIP_RIGHT], bones_depth[eUDKinectSkeletonPosition_KNEE_RIGHT], ColorSkel );
	DrawSkeletonSegment( H, bones_depth[eUDKinectSkeletonPosition_KNEE_RIGHT], bones_depth[eUDKinectSkeletonPosition_ANKLE_RIGHT], ColorSkel );
	DrawSkeletonSegment( H, bones_depth[eUDKinectSkeletonPosition_ANKLE_RIGHT], bones_depth[eUDKinectSkeletonPosition_FOOT_RIGHT], ColorSkel );
}

//-----------------------------------------------------------
private function DrawSkeletonSegment( HUD H, Vector2D Start, Vector2D End, Color ColorSegment )
{
	H.Canvas.Draw2DLine( Start.X, Start.Y, End.X, End.Y, ColorSegment ); 
}

//-----------------------------------------------------------
// Test
//-----------------------------------------------------------

exec function TakeSnapShot()
{
	local int i;
	local UDKinectFrame frame;

	UDKinectGetImageStream( eUDKinectImageType_COLOR, frame );

	for( i=0; i<3; ++i )
	{
		GetALocalPlayerController().ClientMessage( "r" @ frame.buffer[i].Red @ "g" @ frame.buffer[i].Green @ "b" @ frame.buffer[i].Blue );
	}
}

DefaultProperties
{
	Begin Object Class=UDKinectCore Name=UDKinectCore0
	End Object
	m_UDKinectCore=UDKinectCore0
}
