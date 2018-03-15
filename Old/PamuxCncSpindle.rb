class PamuxCncSpindle < PamuxCncModule
  def initialize(cncMachine, parent)
    super(@cncMachine, parent, "spindle")
  end
end