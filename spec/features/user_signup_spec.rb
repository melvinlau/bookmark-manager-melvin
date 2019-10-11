feature 'User sign up' do
  scenario 'User can create an account' do
    visit '/'
    fill_in 'email', with: 'melvin@melvin.com'
    fill_in 'password', with: '123456'
    click_button 'Sign Up'
    expect(page).to have_content 'Welcome, melvin@melvin.com'
  end
end
