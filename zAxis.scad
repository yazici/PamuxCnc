
zAxisWidth = 200;

zAxisOrigin = [xPos - zAxisWidth/2,
				yPos,
				xAxisBottom];

motorFrameOrigin = gantryFrameOrigin + [xPos, -steelTubeSizeNarrow, gantryFrameHeight];



module motorFrame() 
{
    translate(v = motorFrameOrigin)
    {
        CWx()	
            steelFrame(zAxisWidth, gantryFrameHeight, WIDE_FACE_UP);
        
    }
}


module zLinearMotion(color)
{
    translate(v = [steelTubeSizeNarrow/2, -zAxisMotorShaftHeight, -travelZ] ) 
    {
        supportedShaft(color, travelZ, zPos);
    }
    
    translate(v = [zAxisWidth-steelTubeSizeNarrow/2, -zAxisMotorShaftHeight, -travelZ] ) 
    {
        supportedShaft(color, travelZ, zPos);
    }
    
    translate(v = [zAxisWidth/2,  -2*zAxisMotorShaftHeight, -travelZ+steelTubeSizeWide/2] ) 
    {
        
		ballscrewSTL(color, travelZ);
		translate(v = [0, 0, zPos]) 
		{
			ballnutSTL();		
			ballnutHousingSTL();
		}
		floatingBallscrewSupportSTL(travelZ);
		fixedBallscrewSupportSTL();
		shaftCouplerSTL();
    }
}



module zAxis(color)
{
    motorFrame();
    translate(v = motorFrameOrigin ) 
    {
		zLinearMotion(color);
	
    }
}

