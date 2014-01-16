//-----------------------------------------------------------
// 
// UDKinectSeqAct_GetSkeletonPosition.uc 
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

// Get the skeleton position of a given user (also return the tracking state of the given bone)
class UDKinectSeqAct_GetSkeletonPosition extends SequenceAction;

var private UDKinectCore m_UDKinectCore;

var() eUDKinectSkeletonPosition SkeletonPosition;
var() int UserIndex;

event Activated()
{
	local int i, j;
	local int tracking_state;
	local Vector position;
	local SeqVar_Int var_int;
	local SeqVar_Vector var_vect;

	tracking_state = m_UDKinectCore.UDKinectGetSkeletonPosition( UserIndex, SkeletonPosition, position );

	for( i=0; i<VariableLinks.Length; ++i )
	{
		if( VariableLinks[i].LinkDesc == "User index" )
			continue;

		for( j=0; j<VariableLinks[i].LinkedVariables.Length; ++j )
		{
			var_int = SeqVar_Int( VariableLinks[i].LinkedVariables[j] );
			if( var_int != none )
			{
				var_int.IntValue = tracking_state;
			}
			else 
			{
				var_vect = SeqVar_Vector( VariableLinks[i].LinkedVariables[j] );
				if( var_vect != none )
				{
					var_vect.VectValue = position;
				}
			}
		}
	}
}

defaultproperties
{
	bCallHandler = false
	ObjCategory = "UDKinect"
	ObjName = "UDKinect Get Skeleton Position"
	
	VariableLinks(0) = ( ExpectedType=class'SeqVar_Int',LinkDesc="User index", PropertyName=UserIndex )
	VariableLinks(1) = ( ExpectedType=class'SeqVar_Vector',LinkDesc="Position", bWriteable=true )
	VariableLinks(2) = ( ExpectedType=class'SeqVar_Int',LinkDesc="Tracking state", bWriteable=true )
	
	Begin Object Class=UDKinectCore Name=UDKinectCore0
	End Object
	m_UDKinectCore=UDKinectCore0

	SkeletonPosition = eUDKinectSkeletonPosition_HIP_CENTER
	UserIndex = 0
}
