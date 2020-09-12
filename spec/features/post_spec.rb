require 'rails_helper'

describe 'navigate' do
  describe 'index' do
    before do
      visit posts_path
    end

    it 'can be reached successfully' do
      expect(page.status_code).to eq(200)
    end

    it 'has a title of Posts' do
      expect(page).to have_content(/Posts/)
    end
  end

  describe 'creation' do
    before do
      user = User.create({
        first_name: 'test',
        last_name: 'test',
        email: 'test@test',
        password: 'testpass',
        password_confirmation: 'testpass',
      })
      login_as(user, :scope => :user)

      visit new_post_path
    end

    it 'has a new form that can be reached successfully' do
      expect(page.status_code).to eq(200)
    end

    it 'can be create from a new form page successfully' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'Some rationale'
      click_on 'Save'

      expect(page).to have_content('Some rationale')
    end
  
    it 'will have a user associated it' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'user_association'
      click_on 'Save'

      user_posts = User.last.posts;
      expect(user_posts.last.rationale).to eq('user_association')
    end
  end
end