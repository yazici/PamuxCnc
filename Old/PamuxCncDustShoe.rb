class PamuxCncDustShoe < PamuxCncModule
  attr_accessor :cncMachine
  
  def initialize(cncMachine, parent)
    super(cncMachine, parent, "dust shoe")
  end
  
  
end