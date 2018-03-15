class PamuxCncLimitSwitch < PamuxCncModule
  attr_accessor :axis
  
  def initialize (cncMachine, parent)
    super(cncMachine, parent, "#{parent.name} limit switch")
    @axis = parent    
  end
end