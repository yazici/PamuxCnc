#require 'sketchup.rb'


# naming assumes top view
#  Up: Green Axis (Y+)
# Right: Red Axis (X+)
#  Down: Green Axis (Y-)
# Left: Red Axis (X-)
# Elevation: Z Axis


# 3DWarehouse: PARTCommunity

class PamuxCncMachine < PamuxCncObject
  @@perAxisExtraLength = 30
  @@gantryExtraLength = 30
  
  attr_accessor :baseTable
  
  attr_accessor :xAxis
  attr_accessor :yAxis
  attr_accessor :zAxis
  
  attr_accessor :fixedGantry
  
  attr_accessor :spindle
  attr_accessor :powerSupply
  attr_accessor :coolant
  attr_accessor :dustShoe
  attr_accessor :controller
  
  def tableXLength
    @xAxis.length + @@perAxisExtraLength
  end
  
  def tableYLength
    @yAxis.length + @@perAxisExtraLength + @@gantryExtraLength
  end

  def initialize xAxisLength, yAxisLength, zAxisLength   
    super(self, self, "Pamux Cnc Machine", "")
    
    @baseTable = PamuxCncBaseTable.new self, self
    
    @xAxis = PamuxCncAxis.new self, @baseTable, "x", xAxisLength    

    @fixedGantry = PamuxCncFixedGantry.new self, @baseTable
    
    @yAxis = PamuxCncAxis.new self, @fixedGantry, "y", yAxisLength
    @zAxis = PamuxCncAxis.new self, @yAxis, "z", zAxisLength
    
    @spindle = PamuxCncSpindle.new self, @zAxis
    
    @coolant = PamuxCncCoolant.new self, @zAxis
    @dustShoe = PamuxCncDustShoe.new self, @zAxis
    
    @powerSupply = PamuxCncPowerSupply.new self, @baseTable
    
    @controller = PamuxCncController.new self, @baseTable
    
    
  end
  
  def to_s
    "#{@xAxis.length} #{@yAxis.length} #{@zAxis.length}"
  end
  
  def finalTest
    PamuxReporting.startVerification "Final Test"    
    PamuxReporting.finishVerification
  end 
  
  def build
    puts "Building PamuxCncMachine #{self}!"
    
    PamuxReporting.indent
    
    @baseTable.build
    
    @xAxis.build   
    
    PamuxReporting.startConnectingModules @baseTable, @xAxis
    PamuxReporting.reportAlignmentStep "x-axis shafts are parallel"
    PamuxReporting.finishConnectingModules

    @fixedGantry.build
    
    PamuxReporting.startConnectingModules @baseTable, @fixedGantry
    PamuxReporting.reportAlignmentStep "gantry is perpendicular to x-axis"
    PamuxReporting.finishConnectingModules
    
    @yAxis.build
    
    PamuxReporting.startConnectingModules @fixedGantry, @yAxis
    
    PamuxReporting.reportAlignmentStep "yAxis is perpendicular to x-axis"
    PamuxReporting.finishConnectingModules
    
    
    @cncMachine.zAxis.build
    
    @powerSupply.build
    
    @controller.build
    
    @xAxis.buildLimitSwitches
    @yAxis.buildLimitSwitches
    @zAxis.buildLimitSwitches
    
    @spindle.build
    @dustShoe.build
    @coolant.build
    
    finalTest
  end
end