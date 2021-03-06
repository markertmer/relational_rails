require 'rails_helper'

RSpec.describe 'the musicians index page' do

  before :each do
    @metallica = Band.create!(name:'Metallica', founded:1981, genre:'metal', currently_active:true)
    @beatles = Band.create!(name:'The Beatles', founded:1960, genre:'rock & roll', currently_active:false)

    @cliff = @metallica.musicians.create!(name:'Cliff Burton', instrument:'bass', founding_member:false, born:1962)
    @kirk = @metallica.musicians.create!(name:'Kirk Hammett', instrument:'lead guitar', founding_member:false, born:1962)
    @james = @metallica.musicians.create!(name:'James Hetfield', instrument:'rhythm guitar, lead vocals', founding_member:true, born:1963)
    @lars = @metallica.musicians.create!(name:'Lars Ulrich', instrument:'drums', founding_member:true, born:1963)

    @john = @beatles.musicians.create!(name:'John Lennon', instrument:'guitar, vocals', founding_member:true, born:1940)

  end

  it 'User Story 5, Parent Children Index' do

    visit "/bands/#{@metallica.id}/musicians"
    # save_and_open_page

    expect(page).to have_content(@metallica.name)

    expect(page).to have_content(@cliff.name)
    expect(page).to have_content(@cliff.instrument)
    expect(page).to have_content(@kirk.name)
    expect(page).to have_content(@kirk.instrument)
    expect(page).to have_content(@james.name)
    expect(page).to have_content(@james.instrument)
    expect(page).to have_content(@lars.name)
    expect(page).to have_content(@lars.instrument)

    expect(page).to_not have_content(@john.name)
    expect(page).to_not have_content(@john.instrument)
  end

  it 'User Story 8, Child Index Link' do
    visit "/bands/#{@metallica.id}/musicians"

    expect(page).to have_link("Musicians Index")
    click_link "Musicians Index"
    # save_and_open_page

    expect(page).to have_content(@john.name)
    expect(page).to have_content(@lars.name)
  end

  it 'User Story 9, Parent Index Link' do
    visit "/bands/#{@metallica.id}/musicians"

    expect(page).to have_link("Bands Index")
    click_link "Bands Index"
    # save_and_open_page

    expect(page).to have_content(@metallica.name)
    expect(page).to have_content(@beatles.name)
  end


  it 'User Story 16, Sort Parents Children in Alphabetical Order by name' do
    visit "/bands/#{@metallica.id}/musicians"

    within(".index-0") do
      expect(page).to have_content(@cliff.name)
    end
    within(".index-1") do
      expect(page).to have_content(@james.name)
    end
    within(".index-2") do
      expect(page).to have_content(@kirk.name)
    end
    within(".index-3") do
      expect(page).to have_content(@lars.name)
    end
  end

  it 'User Story 18, Child Update from Childs Index Page' do
    visit "/bands/#{@metallica.id}/musicians"

    within("#musician-#{@cliff.id}") do
      click_link "edit musician"
      expect(current_path).to eq("/musicians/#{@cliff.id}/edit")
    end

    visit "/bands/#{@metallica.id}/musicians"

    within("#musician-#{@lars.id}") do
      click_link "edit musician"
      expect(current_path).to eq("/musicians/#{@lars.id}/edit")
    end
  end

  it 'User Story 23, Child Delete from Childs Index Page' do
    visit "/bands/#{@metallica.id}/musicians"

    expect(page).to have_content(@cliff.name)
    expect(page).to have_content(@kirk.name)
    expect(page).to have_content(@james.name)
    expect(page).to have_content(@lars.name)

    within("#musician-#{@cliff.id}") do
      expect(page).to have_link("delete musician")
      click_link "delete musician"
    end

    expect(current_path).to eq("/musicians")
    visit "/bands/#{@metallica.id}/musicians"
    expect(page).to_not have_content(@cliff.name)
    expect(page).to have_content(@kirk.name)
    expect(page).to have_content(@james.name)
    expect(page).to have_content(@lars.name)

    within("#musician-#{@kirk.id}") do
      expect(page).to have_link("delete musician")
      click_link "delete musician"
    end

    expect(current_path).to eq("/musicians")
    visit "/bands/#{@metallica.id}/musicians"
    expect(page).to_not have_content(@cliff.name)
    expect(page).to_not have_content(@kirk.name)
    expect(page).to have_content(@james.name)
    expect(page).to have_content(@lars.name)

    within("#musician-#{@james.id}") do
      expect(page).to have_link("delete musician")
      click_link "delete musician"
    end

    expect(current_path).to eq("/musicians")
    visit "/bands/#{@metallica.id}/musicians"
    expect(page).to_not have_content(@cliff.name)
    expect(page).to_not have_content(@kirk.name)
    expect(page).to_not have_content(@james.name)
    expect(page).to have_content(@lars.name)

    within("#musician-#{@lars.id}") do
      expect(page).to have_link("delete musician")
      click_link "delete musician"
    end

    expect(current_path).to eq("/musicians")
    visit "/bands/#{@metallica.id}/musicians"
    expect(page).to_not have_content(@cliff.name)
    expect(page).to_not have_content(@kirk.name)
    expect(page).to_not have_content(@james.name)
    expect(page).to_not have_content(@lars.name)
  end

end
