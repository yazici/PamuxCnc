// original design by Dirk Herrendoerfer
// GPLv2.0 github: https://github.com/dherrendoerfer/uCNC_controller/tree/master/Extras/Plotter_v3
// compiled for openscad by jegb

module rod(l,d){
    cylinder(h=l, r=d/2,$fn=25);
    }//rod(300,5);
    
module bushing(id,od,l){
    difference(){
        cylinder(h=l, r=od/2,$fn=25);
        cylinder(h=l+0.1, r=id/2,$fn=25); 
        }
    } //bushing(6,12,19);
    
module X1(){
	import("Plotter-v3-x-bridge-1.stl");
}//X1();

module X2(){
	import("Plotter-v3-x-bridge-2.stl");
}//X2();

module X_sled(){
	import("Plotter-v3-x-sled-1.stl");
}//X_sled();

module X_sled_bushing(){ // needs more work
	translate([0,-15,-5]) import("Plotter-v3-x-sled-1.stl");
    translate([3,-10,0]) rotate(a=90,v=[0,1,0]) bushing(6,12,14);
    translate([3,10,0]) rotate(a=90,v=[0,1,0]) bushing(6,12,14);
}//X_sled_bushing();

module Y_1(){
	import("Plotter-v3-y-bridge-1.stl");
}//Y_1();

module Y_2(){
	import("Plotter-v3-y-bridge-2.stl");
}//Y_2();

module Y_3(){
	import("Plotter-v3-y-bridge-3.stl");
}//Y_3();

module Y_4(){
	import("Plotter-v3-y-bridge-4.stl");
}//Y_4();

module Y_sled_bushing(){// needs more work
	rotate(a=90,v=[0,0,1]) translate([-174.7,-20,-5]) import("Plotter-v3-y-bridge-3.stl");
    translate([-19/2,-26,0]) rotate(a=90,v=[0,1,0]) bushing(6,12,19);
    translate([-19/2,26,0]) rotate(a=90,v=[0,1,0]) bushing(6,12,19);
}//Y_sled_bushing();

module pen_1(){
	import("Plotter-v3-z-PenMount-1.stl");
}//pen_1();

module pen_top(){ //ring top servo
	translate([-28.5,-55.5,4]) import("Plotter-v3-z-PenMount-2.stl");
    translate([-8,-75.4,0])import("Plotter-v3-z-PenMount-4.stl");
}//pen_top();

module pen_holder(){ //ring square
	rotate(a=-90,v=[0,0,1]) translate([0,-51.5,0]) import("Plotter-v3-z-PenMount-3.stl");
    
}//pen_holder();
module pen_3a(){
	import("Plotter-v3-z-PenMount-3a.stl");
}//pen_3a();



module assy(l,w){
    //X axis
	translate([l,0,52]) rotate(a=90,v=[0,1,0]) X1();
	translate([0,45+0.07,114.275]) rotate(a=180,v=[0,0,1]) rotate(a=90,v=[0,1,0]) X2();
    // rods X
    color("silver") translate([-5,22.5,27]) rotate(a=90,v=[0,1,0]) rod(l+10,6);
    color("silver") translate([-5,22.5,47]) rotate(a=90,v=[0,1,0]) rod(l+10,6);
    
    //Y axis
    translate([30+l/2,w/2+5,14]) rotate(a=180,v=[0,1,0]) Y_1();
    translate([l/2,-w/2+5,0]) translate([-102,0,14]) rotate(a=180,v=[0,0,1]) rotate(a=180,v=[0,1,0]) Y_2();
    
    // rods Y
    color("silver")  translate([l/2-52/2,-w/2,10]) rotate(a=90,v=[0,0,1]) rotate(a=90,v=[0,1,0]) rod(w+10,6);
    color("silver")  translate([l/2+52/2,-w/2,10]) rotate(a=90,v=[0,0,1]) rotate(a=90,v=[0,1,0]) rod(w+10,6);
    //todo add bushings
    
    //tray and carrier
    color("white") translate([175+l/2,-20,15]) rotate(a=180,v=[0,1,0])  Y_3();//carrier
    translate([l/2-1.5,3,17]) rotate(a=180,v=[1,0,0]) translate([-50,-75,0]) Y_4();//tray

    //Pen carriage
    translate([l/2,17.5,0]) translate([-10,0,37]) rotate(a=-90,v=[1,0,0]) translate([0,-15,0]) X_sled();
    //todo add bushings
    
    translate([l/2-1,17,20]) rotate(a=90,v=[0,0,1]) rotate(a=-90,v=[0,1,0]) translate([0,-30,0]) pen_1();
    translate([l/2,5,75]) pen_top();
    translate([l/2,17,45]) pen_holder();
    translate([l/2,17,63]) rotate(a=180,v=[0,1,0]) pen_holder();

}assy(110,100); // min : 110x100