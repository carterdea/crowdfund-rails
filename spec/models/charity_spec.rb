# == Schema Information
#
# Table name: charities
#
#  id              :integer          not null, primary key
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  donations_count :integer          default(0)
#

require 'rails_helper'

RSpec.describe Charity, type: :model do
end
