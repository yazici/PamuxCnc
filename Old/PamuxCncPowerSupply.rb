class PamuxCncPowerSupply < PamuxCncModule
  def initialize (cncMachine, parent)
    super(cncMachine, parent, "power supply")
  end
end