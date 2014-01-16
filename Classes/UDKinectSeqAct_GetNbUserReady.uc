//-----------------------------------------------------------
// 
// UDKinectSeqAct_GetNbUserReady.uc 
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

// Get the number of users ready (= number of skeleton detected, up to 2)
class UDKinectSeqAct_GetNbUserReady extends SequenceAction;

var private UDKinectCore m_UDKinectCore;

event Activated()
{
	local int nb_user, i;
	local SeqVar_Int var_int;

	nb_user =  m_UDKinectCore.UDKinectGetNbUserReady();

	if( VariableLinks.Length >= 1 )
	{
		for( i=0; i<VariableLinks[0].LinkedVariables.Length; ++i )
		{
			var_int = SeqVar_Int( VariableLinks[0].LinkedVariables[i] );
			if( var_int != none )
			{
				var_int.IntValue = nb_user;
			}
		}
	}
}

defaultproperties
{
	bCallHandler = false
	ObjCategory = "UDKinect"
	ObjName = "UDKinect Get Nb User Ready"
	
	VariableLinks(0) = ( ExpectedType=class'SeqVar_Int',LinkDesc="Nb users", bWriteable=true )
	
	Begin Object Class=UDKinectCore Name=UDKinectCore0
	End Object
	m_UDKinectCore=UDKinectCore0
}
