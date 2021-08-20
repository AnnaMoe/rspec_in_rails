Warden::Manager.after_set_user do |user, auth, opts| 
  scope = opts[:scope] 
  #sets the cookie for the current user and makes it available for the find_current_user method
  auth.cookies.signed["#{scope}.id"] = user.id
end

Warden::Manager.before_logout do |user, auth, opts| 
  scope = opts[:scope] 
  # clears out the cookie when the user signs out
  auth.cookies.signed["#{scope}.id"] = nil
end