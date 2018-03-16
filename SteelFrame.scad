$fn=30;
littleLonger = 0.01;

// http://www.onlinemetals.com/merchant.cfm?pid=22487&step=4&showunits=inches&id=1646&top_cat=197
// 1018 MILD STEEL SQUARE TUBE (METRIC SIZE) 40MM X 3MM WALL 60" LONG

//steelTubeSizeX = 40;
//steelTubeSizeY = 40;
//steelTubeWallThickness = 3;
//steelTubeCornerRadius = 0.25 * 25.4;

// http://www.onlinemetals.com/merchant.cfm?pid=10326&step=4&showunits=inches&id=845&top_cat=849



steelTubeSizeX = (1+1/2) * 25.4;   // 38.1 mm
steelTubeSizeY = (1+1/2) * 25.4;   // 38.1 mm
steelTubeWallThickness = 0.12 * 25.4; // 3.048mm
//steelTubeWallThickness = 0.1875 * 25.4; // 4.7625

steelTubeCornerRadius = 0.25 * 25.4;

//steelTubeSizeX = 1; 
//steelTubeSizeY = 2; 
//steelTubeWallThickness = 0.2;
//steelTubeCornerRadius = 0.1;


module miterCutTriangle(sizeX, sizeY, height)
{
    cornerRadius = 0.001;
    hull()
    {
        translate([cornerRadius-littleLonger,cornerRadius-littleLonger,0]) {
            cylinder(r = cornerRadius, h = height);
        }
        
        
         translate([sizeX-cornerRadius+littleLonger, cornerRadius-littleLonger, 0]) {
            cylinder(r = cornerRadius, h = height);
        }
        
         translate([cornerRadius-littleLonger, sizeY-cornerRadius+littleLonger, 0]) {
            cylinder(r = cornerRadius, h = height);
        }
    }
}


module rightTriangle(sizeX, sizeY, height)
{
    polyhedron(
               points=[[0,0,0], [sizeX, 0, 0], [0, sizeY, 0], 
                       [0,0,height], [sizeX, 0, height], [0, sizeY, height]],
    // Clockwise, lookiong from outside inwards
               faces=[[2,1,0],[5,3,4],[2, 5, 4, 1], [5,2,0,3], [1,4,3,0]]
               );
    
}

module roundedSquareRod(sizeX, sizeY, length, cornerRadius)
{
    color(Steel) { 
      hull()
      {
          translate([cornerRadius, cornerRadius, 0]) {
              cylinder(r = cornerRadius, h = length);
          }
          
          
           translate([cornerRadius, sizeY - cornerRadius, 0]) {
              cylinder(r = cornerRadius, h = length);
          }
          
           translate([sizeX-cornerRadius, sizeY-cornerRadius, 0]) {
              cylinder(r = cornerRadius, h = length);
          }
          
           translate([sizeX-cornerRadius, cornerRadius, 0]) {
              cylinder(r = cornerRadius, h = length);
          }
      }
    }
}

module roundedSquareTube(sizeX, sizeY, length, cornerRadius, wallThickness)
{
    difference() {
        roundedSquareRod(sizeX, sizeY, length, cornerRadius);
        translate([wallThickness,wallThickness,-littleLonger/2]) {
            roundedSquareRod(sizeX-wallThickness*2, sizeY-wallThickness*2, length+littleLonger, cornerRadius/2);
        }
    }
}

module bottomMiterCut(sizeX, sizeY)
{

  translate(v=[0,sizeY,0]) 
  {
    rotate(a = 90, v=[1,0,0])
    {

      miterCutTriangle(min(sizeX, sizeY), min(sizeX, sizeY), height = sizeY);
    }
  }
}

module topMiterCut(sizeX, sizeY, length)
{
  translate(v=[0,0,length]) 
  {
    rotate(a = -90, v=[1,0,0])
    {
      miterCutTriangle(min(sizeX, sizeY), min(sizeX, sizeY), height = sizeY);
    }
  }
}

module miteredRoundedSquareTube(sizeX, sizeY, length, cornerRadius, wallThickness)
{
    
    difference()
    {
        difference()
        {
            roundedSquareTube(sizeX, sizeY, length, cornerRadius, wallThickness);
            bottomMiterCut(sizeX, sizeY);
        }
        topMiterCut(sizeX, sizeY, length);
    }    
}

module frameBottomTube(frameSizeX, frameSizeY)
{ 
    translate(v=[0, steelTubeSizeX, steelTubeSizeY]) {
        rotate(a = -90, v = [1,0,0]) {
        rotate(a = 90, v = [0,1,0]) {
            miteredRoundedSquareTube(steelTubeSizeX, steelTubeSizeY, frameSizeX, steelTubeCornerRadius, steelTubeWallThickness); 
        }
    }
    }
}

module frameTopTube(frameSizeX, frameSizeY)
{ 
    translate(v=[0, frameSizeY-steelTubeSizeX, 0]) {
        rotate(a = 90, v = [1,0,0]) {
        rotate(a = 90, v = [0,1,0]) {
            miteredRoundedSquareTube(steelTubeSizeX, steelTubeSizeY, frameSizeX, steelTubeCornerRadius, steelTubeWallThickness); 
        }
    }
    }
}


module frameLeftTube(frameSizeX, frameSizeY) 
{ 
    translate(v=[steelTubeSizeX, 0, 0])
    {
        rotate(a = 180, v = [0, 1,0]) {
            rotate(a = -90, v = [1,0,0])
            {
                miteredRoundedSquareTube(steelTubeSizeX, steelTubeSizeY, frameSizeY, steelTubeCornerRadius, steelTubeWallThickness); 
            }
        }
    }
}
module frameRightTube(frameSizeX, frameSizeY) 
{ 
    translate(v=[frameSizeX-steelTubeSizeX, 0, steelTubeSizeY])
    {
        rotate(a = -90, v = [1,0,0])
        {
            miteredRoundedSquareTube(steelTubeSizeX, steelTubeSizeY, frameSizeY, steelTubeCornerRadius, steelTubeWallThickness); 
        }
    }
}

module steelFrame(frameSizeX, frameSizeY) {

    union() {
        frameLeftTube(frameSizeX, frameSizeY);
        
        frameRightTube(frameSizeX, frameSizeY);
    }

    union() {
        frameBottomTube(frameSizeX, frameSizeY);
        
        frameTopTube(frameSizeX, frameSizeY);
    }
}

