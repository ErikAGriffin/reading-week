require 'spec_helper'

describe User do

  let(:user) {User.new(username:'Erik')}

  it "Has a username" do
    expect(user.username).to eq 'Erik'
  end





end