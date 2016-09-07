class ReferenceAuthenticationsUserIDtoUsersId < ActiveRecord::Migration
  def change
    add_foreign_key "authentications", "users", name: "authentications_user_id_fk"
  end
end
