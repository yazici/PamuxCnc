

littleLonger = 0.01;



echo(version=version());

 

x = [1, 0, 0];

y = [0, 1, 0];

z = [0, 0, 1];

 


module roundedSquareRod(sizeX, sizeY, length, cornerRadius)

{

   hull()

    {

        translate([-sizeX, -sizeY, 0]) {

            cylinder(r = cornerRadius, h = length);

        }

       

        

         translate([sizeX, -sizeY, 0]) {

            cylinder(r = cornerRadius, h = length);

        }

       

         translate([-sizeX, sizeY, 0]) {

            cylinder(r = cornerRadius, h = length);

        }

       

         translate([sizeX, sizeY, 0]) {

            cylinder(r = cornerRadius, h = length);

        }

    }

}


module make_ring_of(radius, count)
{
    for (a = [0 : count - 1]) {
        angle = a * 360 / count;
        translate(radius * [sin(angle), -cos(angle), 0])
            rotate([0, 0, angle])
                children();
    }
}



module roundedSquareTube(sizeX, sizeY, length, cornerRadius, wallThickness)
{
    difference() {

        roundedSquareRod(sizeX, sizeY, length, cornerRadius);

        translate([0,0,-littleLonger/2]) {

            roundedSquareRod(sizeX-wallThickness, sizeY-wallThickness, length+littleLonger, cornerRadius);

        }

    }

}

 

module miteredRoundedSquareTube(sizeX, sizeY, length, cornerRadius, wallThickness)

{

    roundedSquareTube(sizeX, sizeY, length, cornerRadius, wallThickness);

}