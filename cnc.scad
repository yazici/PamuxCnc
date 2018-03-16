include <SteelFrame.scad>
include <Fasteners.scad>
include <LinearActuators.scad>
include <LinearMotion.scad>
include <xAxis.scad>
include <yAxis.scad>
include <zAxis.scad>
include <Electronics.scad>
include <EndEffector.scad>
include <MCAD\motors.scad>
include <MCAD\materials.scad>
//include <SCxxUU-SCxxLUU_v04.scad>
//!import("C:/mysrc/PamuxCnc/3sides-corner-CNC.stl");
// My Documents\OpenSCAD\libraries
// C:\Program Files\OpenSCAD\libraries\MCAD
// https://github.com/openscad/MCAD
// OPENSCADPATH
// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Libraries
// https://github.com/jreinhardt/local-scad
// https://github.com/FreeCAD/FreeCAD-library/tree/master/Mechanical%20Parts/Bearings/linear_bearings


// Given Machine/Part Parameters
travelX = 1300;
travelY = 1300;
travelZ = 300;

ballScrewDiameter = 20;

shaftDiameter = 20;
shaftSupportHeight = 30;
shaftSupportWidth = 30;

openLinearBearingWidth  = 40;
openLinearBearingLength = 50;
openLinearBearingHeight = 20;
openLinearBearingGap = 100;


// Derived Machine Parameters

tableSizeX = travelX + steelTubeSizeX*2;
tableSizeY = travelY + steelTubeSizeX*2; 
gantryFrameHeight = travelZ;



xAxisMotorShaftHeight = 30;
yAxisMotorShaftHeight = 30;
zAxisMotorShaftHeight = 30;



shaftHeight = shaftDiameter + shaftSupportHeight;
baseFrameHeight = steelTubeSizeY;


gantryFrameOrigin = [0,tableSizeY/3, baseFrameHeight + shaftHeight + openLinearBearingHeight/2];

gantryFrameGapWidth = 200;

motorFrameOrigin = [gantryFrameOrigin.x+travelX/2,gantryFrameOrigin.y-steelTubeSizeX,gantryFrameOrigin.z];
motorFrameWidth = 200;

//stepper_motor_mount(23);

yAxis();
xAxis();
zAxis();

