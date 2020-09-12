require 'rails_helper'

describe 'navigate' do
  before do
    @current_user = User.create({
      first_name: 'test',
      last_name: 'test',
      email: 'test@test',
      password: 'testpass',
      password_confirmation: 'testpass',
    })
    login_as(@current_user, :scope => :user)
  end

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

    it 'has a list of Posts' do
      post1 = Post.create({
        date: Date.today,
        rationale: 'Post1',
        user_id: @current_user.id
      })
      post2 = Post.create({
        date: Date.today,
        rationale: 'Post2',
        user_id: @current_user.id
      })
      visit posts_path
      expect(page).to have_content(/Post1|Post2/)
    end
  end

  describe 'creation' do
    before do
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