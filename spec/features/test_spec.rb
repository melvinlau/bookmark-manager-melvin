feature 'testing infrastructure' do
  scenario 'index page allows a user to sign in' do
    visit('/')
    expect(page).to have_content("Sign in")
  end
end
