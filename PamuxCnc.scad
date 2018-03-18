use <Pamux.scad> 

$fn=30;
$fs = 0.1;  // Don't generate smaller facets than 0.1 mm
$fa = 5;    // Don't generate larger angles than 5 degrees


steelTubeSize = 1.5 * 2.54;

steelTubeWallThickness = 0.210 * 2.54;

steelTubeCornerRadius = 0.25 * 2.54;
 
tableXSize = 150;
tableYSize = 150;

xTravel = 1300;
yTravel = 1300;
zTravel = 300;


module twoParallelTubes(color, length, distance, angle, pivot)
{
	color(color)
	{
		
		
		
			
		rotate(a = angle, v = pivot)
		{
			translate([steelTubeSize/2,steelTubeSize/2,0])
			{
				miteredRoundedSquareTube(steelTubeSize,   steelTubeSize, length, steelTubeCornerRadius, steelTubeWallThickness);
			}
			
		}
			
			
		translate(distance)
		{	
			rotate(a = angle, v = pivot)
			{
				translate([-steelTubeSize,-steelTubeSize,0])
				{
					//miteredRoundedSquareTube(steelTubeSize,   steelTubeSize, length,  steelTubeCornerRadius, steelTubeWallThickness);
				}
			}
		}
		
	}
}


module steelTubeFrame(xSize, ySize)
{
	
	miteredRoundedSquareTube(steelTubeSize,   steelTubeSize, xSize, steelTubeCornerRadius, steelTubeWallThickness);
	
	twoParallelTubes("red",   xSize, [0,ySize,0],  90, [0,1,0]);
	//twoParallelTubes("green", ySize, [-xSize,0, 0], -90, [1,0,0]);
}

module base()
{
  steelTubeFrame(tableXSize, tableYSize);
}

module supportedShafts()
{
}

module ballScrew()
{
}

module motor()
{
}

module gantry()
{
}

module toolHolder()
{
}

module yAxis()
{
  base();
  supportedShafts();
  ballScrew();
  motor();
}

module xAxis()
{
  gantry();
  supportedShafts();
  ballScrew();
  motor();
}

module zAxis()
{
  supportedShafts();
  ballScrew();
  toolHolder();
}
  
  
module movingGantry3AxisCnc()
{
  yAxis();
  xAxis();
  zAxis();
  
}
 

movingGantry3AxisCnc();
