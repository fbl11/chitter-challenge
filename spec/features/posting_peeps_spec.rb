describe 'Chitter Features' do
  # As a Maker
  # So that I can let people know what I am doing  
  # I want to post a message (peep) to chitter

  feature 'The user can post a new message' do
    scenario 'the user can submit a message they typed on the page' do
      visit '/'
      fill_in('new_peep', with: 'THIS IS A TEST PEEP')
      click_button('Submit')
      expect(page.status_code).to eq(200)
      expect(page).to have_content('THIS IS A TEST PEEP')
    end
  end

end
