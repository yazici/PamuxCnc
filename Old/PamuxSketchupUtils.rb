require 'sketchup.rb'

# naming assumes top view
#  Up: Green Axis (Y+)
# Right: Red Axis (X+)
#  Down: Green Axis (Y-)
# Left: Red Axis (X-)
# Elevation: Z Axis

SKETCHUP_CONSOLE.show

def reload
  #$pluginPath
  load $scriptPath
end


def copy_selected_component()

  mod  = Sketchup::active_model
  sel  = mod.selection
  ents = mod.active_entities
  
  return false if sel.empty?
  cget = sel.grep( Sketchup::ComponentInstance )
  return false if cget.empty?
  cmp1 = cget.first
  def1 = cmp1.definition

  copy = ents.add_instance( def1, IDENTITY )
  if copy.is_a?(Sketchup::ComponentInstance)
    return copy
  else
    return false 
  end

end # method

def nest_selected_component(def_name = "My New Definition")
  mod  = Sketchup::active_model
  sel  = mod.selection
  ents = mod.active_entities
  
  return false if sel.empty?
  cget = sel.grep( Sketchup::ComponentInstance )
  return false if cget.empty?
  cmp1 = cget.first
  def1 = cmp1.definition
  
  def2 = mod.definitions.add( def_name )
  copy = def2.entities.add_instance( def1, IDENTITY )
  if copy
    copy.explode
  else
    return false
  end
  
  cmp2 = ents.add_instance( def2, cmp1.transformation )
  if cmp2.nil?
    return false
  else
    cmp2.glued_to= cmp1.glued_to unless cmp1.glued_to.nil?
    cmp2.casts_shadows= cmp1.casts_shadows
    cmp2.receives_shadows= cmp1.receives_shadows
    cmp2.layer= cmp1.layer
    cmp2.material= cmp1.material
    cmp2.name= cmp1.name
    if cmp1.attribute_dictionaries
      copy_attribute_dictionaries(cmp1,cmp2)
    end
    cmp2.hidden= cmp1.hidden
    cmp2.locked= cmp1.locked
    # cmp1.erase! # if you no longer need it.
    return cmp2
  end

end # method


def copy_attribute_dictionaries( source, target )
  unless source.is_a?(Sketchup::Entity) && target.is_a?(Sketchup::Entity)
    fail(TypeError,"objects of Sketchup::Entity (or subclass) expected",caller)
  end
  source.attribute_dictionaries.each {|dict1|
    dict2 = target.attribute_dictionary(dict1.name,true)
    dict1.each {|key,val|
      next if key.nil? || (key.is_a?(String) && key.empty?)
      dict2[key]= val
    }
    if dict1.attribute_dictionaries
      # since Dictionary is a Entity subclass, they can be nested.
      copy_attribute_dictionaries(dict1,dict2) # recursive call
    end
  }
end # method




