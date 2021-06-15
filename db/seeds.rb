User.create!(
  name: 'administrator',
  email: 'admin@admin.com',
  password: ENV['ADMIN_PASS'],
  password_confirmation: ENV['ADMIN_PASS'],
  profile_image: File.open('./app/assets/images/admin_img.png'),
  admin: true
)