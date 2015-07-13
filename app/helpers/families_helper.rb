module FamiliesHelper

  def total_raised
    
  end

  def self.formatted_cost(family)
    "$" + number_with_delimiter(family.cost)
  end
end
