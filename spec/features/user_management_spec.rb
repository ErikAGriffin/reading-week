require 'spec_helper'

feature 'User signs up' do

  scenario 'When visiting home page for the first time evah' do
    expect{sign_up}.to change(User, :count).by 1
    expect(page).to have_content "Thanks, Erik"
  end

  scenario 'A user signs out' do
    sign_up
    click_link 'Log Out'
    expect(page).to have_content "Come Back Soon"
    expect(page).to have_content "Back to Home Page"
  end

end

feature 'Existing user can sign in' do

  scenario 'After having signed up and out' do
    sign_up
    click_link "Log Out"
    visit '/'
    sign_in
    expect(page).to have_content "Thanks, Erik"
  end

end

def sign_in
  click_link("Log In")
  expect(page.status_code).to eq 200
  fill_in :username, with: 'Erik'
  fill_in :password, with: "QWERTY!123"
  click_button "Sign In"
end



def sign_up(password="QWERTY!123", confirmation="QWERTY!123")
  visit '/users/new'
  expect(page.status_code).to eq 200
  fill_in :username, with: 'Erik'
  fill_in :password, with: password
  fill_in :password_confirmation, with: confirmation
  click_button "Sign Up"
end













