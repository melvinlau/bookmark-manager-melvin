feature 'Authentication' do
  scenario 'user can sign in' do
    user = User.create(email: 'melvin@melvin.com', password: '12345')
    visit '/'
    fill_in('signin_email', with: 'melvin@melvin.com')
    fill_in('signin_password', with: '12345')
    click_button('Sign In')
    expect(page).to have_content "Welcome, #{user.email}"
  end

  scenario 'a user sees an error if they get their email wrong' do
    User.create(email: 'melvin@melvin.com', password: '12345')
    visit '/'
    fill_in('signin_email', with: 'hello@melvin.com')
    fill_in('signin_password', with: '12345')
    click_button('Sign In')
    expect(page).not_to have_content 'Welcome, melvin@melvin.com'
    expect(page).to have_content 'Please check your email or password.'
  end

  scenario 'a user sees an error if they get their password wrong' do
    User.create(email: 'melvin@melvin.com', password: '12345')
    visit('/')
    fill_in('signin_email', with: 'melvin@melvin.com')
    fill_in('signin_password', with: 'abc123')
    click_button('Sign In')

    expect(page).not_to have_content 'Welcome, melvin@melvin.com'
    expect(page).to have_content 'Please check your email or password.'
  end

  scenario 'a user can sign out' do
    user = User.create(email: 'melvin@melvin.com', password: '12345')
    visit '/'
    fill_in('signin_email', with: 'melvin@melvin.com')
    fill_in('signin_password', with: '12345')
    click_button('Sign In')
    click_button('Sign Out')
    expect(page).not_to have_content 'Welcome, melvin@melvin.com'
    expect(page).to have_content 'You have signed out.'
  end
end
