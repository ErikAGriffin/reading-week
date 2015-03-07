require 'spec_helper'

feature 'Creating a new Idea' do

  scenario 'A user has signed up, and submits an idea' do
    sign_up
    click_link('Submit Your Idea');
    expect{create_idea}.to change(ProjectIdea, :count).by 1
    expect(page).to have_content "A Twitter Clone"
  end


  def sign_up(password="QWERTY!123", confirmation="QWERTY!123")
    visit '/users/new'
    expect(page.status_code).to eq 200
    fill_in :username, with: 'Erik'
    fill_in :password, with: password
    fill_in :password_confirmation, with: confirmation
    click_button "Sign Up"
  end

  def create_idea
    fill_in :title, with: 'A Twitter Clone'
    fill_in :content, with: "So pretty much exactly like Twitter.. only we call it Chitter.\nAnd make it so every person sees every tweet."
    click_button "Submit"
  end

end
