//-----------------------------------------------------------
// 
// UDKinectCore.uc 
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

class UDKinectCore extends Object
	DLLBind( UDKinect ); 

//-----------------------------------------------------------
// enum
//-----------------------------------------------------------

// bones in a skeleton
enum eUDKinectSkeletonPosition
{
    eUDKinectSkeletonPosition_HIP_CENTER,
    eUDKinectSkeletonPosition_SPINE,
    eUDKinectSkeletonPosition_SHOULDER_CENTER,
    eUDKinectSkeletonPosition_HEAD,
    eUDKinectSkeletonPosition_SHOULDER_LEFT,
    eUDKinectSkeletonPosition_ELBOW_LEFT,
    eUDKinectSkeletonPosition_WRIST_LEFT,
    eUDKinectSkeletonPosition_HAND_LEFT,
    eUDKinectSkeletonPosition_SHOULDER_RIGHT,
    eUDKinectSkeletonPosition_ELBOW_RIGHT,
    eUDKinectSkeletonPosition_WRIST_RIGHT,
    eUDKinectSkeletonPosition_HAND_RIGHT,
    eUDKinectSkeletonPosition_HIP_LEFT,
    eUDKinectSkeletonPosition_KNEE_LEFT,
    eUDKinectSkeletonPosition_ANKLE_LEFT,
    eUDKinectSkeletonPosition_FOOT_LEFT,
    eUDKinectSkeletonPosition_HIP_RIGHT,
    eUDKinectSkeletonPosition_KNEE_RIGHT,
    eUDKinectSkeletonPosition_ANKLE_RIGHT,
    eUDKinectSkeletonPosition_FOOT_RIGHT,
    eUDKinectSkeletonPosition_COUNT
};

// smoothing for skeleton tracking
enum eUDKinectSkeletonSmoothing
{
	eUDKinectSkeletonSmoothing_NONE,
	eUDKinectSkeletonSmoothing_FAST_LOW_LATENCY,
	eUDKinectSkeletonSmoothing_SMOOTH_HIGH_LATENCY
};

// state of a skeleton position
enum eUDKinectSkeletonTrackingState
{
	eUDKinectSkeletonTrackingState_NOT_TRACKED,
	eUDKinectSkeletonTrackingState_POSITION_ONLY,
	eUDKinectSkeletonTrackingState_TRACKED
};

// tracking style of users (user is a layer above skeleton)
enum eUDKinectUserTrackingStyle
{
	eUDKinectUserTrackingStyle_QUEUE,
	eUDKinectUserTrackingStyle_MEMORY
};

// image type you can get from the sensor
enum eUDKinectImageType
{
	eUDKinectImageType_COLOR,
	eUDKinectImageType_DEPTH,
	eUDKinectImageType_ALL
};

struct UDKinectFramePixel
{
	var byte Blue;
	var byte Green;
	var byte Red;
	var byte _Reserved;
};

struct UDKinectFrame
{
	var Array<UDKinectFramePixel> buffer;
};

//-----------------------------------------------------------
// Init / ShutDown
//-----------------------------------------------------------

// use eUDKinectUserTrackingStyle for parameter userTrackingStyle
// use eUDKinectSkeletonSmoothing for parameter skeletonSmoothing
dllimport final function bool   UDKinectInitialize( int userTrackingStyle, int skeletonSmoothing );
dllimport final function        UDKinectShutDown();

//-----------------------------------------------------------
// Nui
//-----------------------------------------------------------

dllimport final function bool   UDKinectIsSensorReady();

dllimport final function        UDKinectSetCameraElevationAngle( int elevation );
dllimport final function int    UDKinectGetCameraElevationAngle();

// use eUDKinectSkeletonSmoothing for parameter smoothingStyle
dllimport final function        UDKinectSetSkeletonSmoothing( int smoothingStyle );

// userIndex: 0 --> player 1, 1 --> player 2 (2 users max --> number limit of skeletons tracked by the kinect sdk)
// use eUDKinectSkeletonPosition for parameter boneId
dllimport final function int    UDKinectGetSkeletonTrackingState( int userIndex, int boneId ); // return int is of type eUDKinectSkeletonTrackingState
dllimport final function int    UDKinectGetSkeletonPosition( int userIndex, int boneId, out Vector bonePosition ); // return int is of type eUDKinectSkeletonTrackingState
dllimport final function        UDKinectGetSkeletonPositionTransformedToDepthImage( int userIndex, int boneId, out Vector2D bonePosition );

// use eUDKinectImageType for parameter imageType
dllimport final function bool   UDKinectGetImageStream( int imageType, out UDKinectFrame frame );

// Returns the skeleton space coordinates of a given pixel in the depth image
dllimport final function        UDKinectTransformDepthImageToSkeleton( out Vector2D depthCoord, out Vector outCoord, int depthValue );

// Returns the depth space coordinates of the specified point in skeleton space
dllimport final function        UDKinectTransformSkeletonToDepthImage( out Vector skelCoord, out Vector2D outCoord2D );

//-----------------------------------------------------------
// User
//-----------------------------------------------------------

// userIndex: 0 --> player 1, 1 --> player 2 (2 users max --> number limit of skeletons tracked by the kinect sdk)
dllimport final function bool	UDKinectIsUserReady( int userIndex );

dllimport final function int    UDKinectGetNbUserReady();

// use eUDKinectUserTrackingStyle for parameter userTrackingStyle
dllimport final function        UDKinectSetUserTrackingStyle( int userTrackingStyle );

//-----------------------------------------------------------
// Preview window
//-----------------------------------------------------------

// use eUDKinectImageType for parameter imageType
dllimport final function        UDKinectShowPreviewWindow( int imageType );
dllimport final function        UDKinectHidePreviewWindow( int imageType );

dllimport final function        UDKinectShowPreviewWindows();
dllimport final function        UDKinectHidePreviewWindows();
	
DefaultProperties
{
}
