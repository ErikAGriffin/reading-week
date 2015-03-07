require 'spec_helper'

describe 'ProjectIdea' do

  let(:idea) {ProjectIdea.create(title: 'Makers Website', content:'A really longwinded description.')}


  it 'Has a Title' do
    expect(idea.title).to eq 'Makers Website'
  end

  it 'Has content' do
    expect(idea.content).to eq 'A really longwinded description.'
  end

  it 'Starts with 0 likes' do
    expect(idea.favorite_count).to eq 0
  end

  it 'Can be liked, incrementing its value' do
    idea.like
    expect(idea.favorite_count).to eq 1
  end

  it 'Can be unliked, decrementing its value' do
    idea.like
    idea.unlike
    expect(idea.favorite_count).to eq 0
  end



end