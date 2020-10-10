User.where(email: 'user@mail.com').first_or_create do |u|
  u.password = 'password123'
end
