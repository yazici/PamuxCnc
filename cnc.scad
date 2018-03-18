include <MCAD\constants.scad>
include <MCAD\motors.scad>
include <MCAD\materials.scad>

$fn=30;

linearBearingWidth = 48;

shaftBottomToLinearBearingVerticalDistance = 50; // SBR20 Datasheet  
linearBearingPlateThickness = 1/4 * mm_per_inch; // 1/4 inch aluminum plate will be driven by the linear bearings and it'll hold the next axis

// Machine/Part Parameters

travelX = 1300;
travelY = 1300;
travelZ = 300;

xPosPercent = 30;
yPosPercent = 30;
zPosPercent = 30;

xAxisMotorShaftHeight = 30;
yAxisMotorShaftHeight = 100;
zAxisMotorShaftHeight = 30;

gantryDepth = 200;


steelTubeSizeNarrow = (1+1/2) * mm_per_inch;   // 38.1 mm
steelTubeSizeWide = (3+1/2) * mm_per_inch;   // 38.1 mm
steelTubeWallThickness = 0.12 * mm_per_inch; // 3.048 mm
//steelTubeWallThickness = 0.1875 * mm_per_inch; // 4.7625 mm
steelTubeCornerRadius = 1/4 * mm_per_inch;

tableSizeX = travelX + steelTubeSizeWide * 2;
tableSizeY = travelY + steelTubeSizeNarrow * 2; 

xPos = xPosPercent * travelX / 100;
yPos = yPosPercent * travelY / 100;
zPos = zPosPercent * travelZ / 100;




include <Utility.scad>

include <SteelFrame.scad>
include <Fasteners.scad>
include <LinearActuators.scad>
include <LinearMotion.scad>

include <yAxis.scad>
include <xAxis.scad>
include <zAxis.scad>

include <Electronics.scad>
include <EndEffector.scad>



// My Documents\OpenSCAD\libraries
// C:\Program Files\OpenSCAD\libraries\MCAD
// https://github.com/openscad/MCAD
// OPENSCADPATH
// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Libraries
// https://github.com/jreinhardt/local-scad
// https://github.com/FreeCAD/FreeCAD-library/tree/master/Mechanical%20Parts/Bearings/linear_bearings

yAxis("green");
xAxis("red");
zAxis("navy");

