//-----------------------------------------------------------
// 
// UDKinectSeqAct_SetPreviewWindow.uc 
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

// Preview windows of the kinect frame
class UDKinectSeqAct_SetPreviewWindow extends SequenceAction;

var private UDKinectCore m_UDKinectCore;

var() eUDKinectImageType PreviewWindowType;
var() bool bShow;

event Activated()
{
	if( PreviewWindowType == eUDKinectImageType_ALL )
	{
		m_UDKinectCore.UDKinectHidePreviewWindows();
		if( bShow )
			m_UDKinectCore.UDKinectShowPreviewWindows();			
	}
	else
	{
		m_UDKinectCore.UDKinectHidePreviewWindow( PreviewWindowType );
		if( bShow )
			m_UDKinectCore.UDKinectShowPreviewWindow( PreviewWindowType );
	}
}

defaultproperties
{
	bCallHandler = false
	ObjCategory = "UDKinect"
	ObjName = "UDKinect Set Preview Window"

	VariableLinks(0) = ( ExpectedType=class'SeqVar_Bool',LinkDesc="Show", PropertyName=bShow )
		
	Begin Object Class=UDKinectCore Name=UDKinectCore0
	End Object
	m_UDKinectCore=UDKinectCore0

	PreviewWindowType = eUDKinectImageType_ALL
	bShow = false
}
