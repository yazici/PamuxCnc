class PamuxCncAxis  < PamuxCncModule  
  attr_accessor :length
  
  attr_accessor :minSwitch
  attr_accessor :maxSwitch
  
  attr_accessor :rail1
  attr_accessor :rail2
  
  attr_accessor :actuator
  
  def initialize(cncMachine, parent, axisName, length)
    super(cncMachine, parent, "#{axisName} axis", "(#{length} mm)")
    @length = length

    @rail1 = PamuxCncShaft.new @cncMachine, self
    @rail2 = PamuxCncShaft.new @cncMachine, self
    
    @actuator = PamuxCncBallScrew.new @cncMachine, self
    
    @minSwitch = PamuxCncLimitSwitch.new @cncMachine, self
    @maxSwitch = PamuxCncLimitSwitch.new @cncMachine, self
  end
  
  def buildVerifyImpl()
    PamuxReporting.reportAlignmentStep "#{name} shafts are parallel to each other and to the ball screw"
  end
  
  def buildLimitSwitches()
    @minSwitch.build
    @maxSwitch.build
  end

end