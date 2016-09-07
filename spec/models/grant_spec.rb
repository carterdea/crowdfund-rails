# == Schema Information
#
# Table name: grants
#
#  id                       :integer          not null, primary key
#  family_id                :integer
#  amount_requested         :decimal(, )
#  expense_description      :text
#  supporting_documentation :string
#  requested_to_name        :string
#  requested_to_address     :string
#  requested_to_city        :string
#  requested_to_state       :string
#  requested_to_zip         :string
#  signature                :boolean
#  status                   :string           default("requested")
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  amount_approved          :decimal(, )
#

require 'rails_helper'
