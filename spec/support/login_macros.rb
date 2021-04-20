module LoginMacros
  def login_as(user)
    visit '/login'
    within('.overview') do
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: 'password'
      find('.button').click
    end
  end
end
