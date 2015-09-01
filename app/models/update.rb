class Update < ActiveRecord::Base
  belongs_to :family

  default_scope { order('created_at DESC') }

  def date_created
    created_at.strftime('%B %e, %Y')
  end

  # def user_message
  #   message.chomp
  # end  
end
