require 'rails_helper'
 
RSpec.describe 'Band show action' do

  # before :each do
  #   @metallica = Band.create!(name:'Metallica', founded:1981, genre:'metal', currently_active:true)
  # end

  # As a visitor
  # When I visit '/parents/:id'
  # Then I see the parent with that id including the parent's attributes:
  # - data from each column that is on the parent table

  it 'User Story 2, Parent Show displays all Band information' do
    beatles = Band.create!(name:'The Beatles', founded:1960, genre:'rock & roll', currently_active:false)
    sleep 2
    devo = Band.create!(name:'DEVO', founded:1973, genre:'new wave', currently_active:true)


    visit "/bands/#{beatles.id}"
    save_and_open_page

    expect(page).to have_content(beatles.id)
    expect(page).to_not have_content(devo.id)
    expect(page).to have_content(beatles.name)
    expect(page).to_not have_content(devo.name)
    expect(page).to have_content(beatles.founded)
    expect(page).to_not have_content(devo.founded)
    expect(page).to have_content(beatles.genre)
    expect(page).to_not have_content(devo.genre)
    expect(page).to have_content(beatles.currently_active)
    expect(page).to_not have_content(devo.currently_active)
    expect(page).to have_content(beatles.created_at)
    expect(page).to_not have_content(devo.created_at)
    expect(page).to have_content(beatles.updated_at)
    expect(page).to_not have_content(devo.updated_at)
  end
end
