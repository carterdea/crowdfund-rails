class UpdateMailer < ApplicationMailer
  def send_update(update, family)
    @family = family
    @update = update
  end
end
