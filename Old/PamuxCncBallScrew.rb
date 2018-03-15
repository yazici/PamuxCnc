class PamuxCncBallScrew < PamuxCncModule
  attr_accessor :axis
  
  def initialize(cncMachine, parent)
    super(cncMachine, parent, "#{parent.name} Ball Screw")
    @axis = parent    
  end
end