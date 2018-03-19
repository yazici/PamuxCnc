yAxisOrigin = [0,0,0];

baseFrameHeight = steelTubeSizeWide;


linearBearingTop = baseFrameHeight + shaftBottomToLinearBearingTopDistance;
yAxisTop = linearBearingTop + mountingPlateThickness;

module baseFrame()
{
    steelFrame(tableSizeX, tableSizeY, NARROW_FACE_UP);
	
	horizontalBeam(tableSizeX, NARROW_FACE_UP, tableSizeY*2/3);
    horizontalBeam(tableSizeX, NARROW_FACE_UP, tableSizeY/3);
}

function frameTubeCenterX(side) = side == MASTER 
					? steelTubeSizeNarrow/2 
					: tableSizeX - (steelTubeSizeNarrow/2);
					
function yAxisBallscrewX(side) = side == MASTER 
					? steelTubeSizeNarrow/2 - nutHousingWidth
					: tableSizeX - (steelTubeSizeNarrow/2- nutHousingWidth);
				


				
module yAxisSingleSideLinearMotionComponents(colorScheme, side)
{
	tubeCenterX = frameTubeCenterX(side);

	ballscrewX = yAxisBallscrewX(side);
	shaftY = baseFrameHeight;
	ballscrewY = linearBearingTop;
	
	
	translate(v = [tubeCenterX, -steelTubeSizeWide, 0] ) 
	{
		supportedShaft(colorScheme, travelY, yPos);			
	}
	
	translate(v = [ballscrewX, -ballscrewAssemblyHeight-steelTubeSizeWide, 0] ) 
	{			
		ballscrewAssembly(colorScheme, travelY, yPos);
	} 
}



module yLinearMotion(colorScheme)
{
	yAxisSingleSideLinearMotionComponents(colorScheme, MASTER);	
	yAxisSingleSideLinearMotionComponents(colorScheme, SLAVE); 
	
	endToEndMountingPlate(colorScheme, 
							steelTubeSizeWide+shaftBottomToLinearBearingTopDistance, 
							openLinearBearingOutsideGap, 
							tableSizeX,
							nutHousingWidth *4/3,		// TODO					
							yPos);
}



module yAxis()
{
	colorScheme = getColorScheme("yAxis");
        
    translate(v = [0, 0, steelTubeSizeWide])  
		CCWx() 
			baseFrame(); 
    
	CCWx()
		yLinearMotion(colorScheme);
	
}
