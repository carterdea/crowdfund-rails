# == Schema Information
#
# Table name: updates
#
#  id            :integer          not null, primary key
#  family_id     :integer
#  title         :string
#  message       :text
#  email_donors  :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  sequential_id :integer
#  photo         :string
#  video_url     :string
#

require 'rails_helper'

describe Update, '#action' do
  
end
