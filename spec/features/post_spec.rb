require 'rails_helper'

describe 'navigate' do
  before do
    @current_user = FactoryGirl.create(:user)
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
      post1 = FactoryGirl.create(:post)
      post2 = FactoryGirl.create(:second_post)
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

  describe 'new' do
    it 'has a link from the homepage' do
      visit root_path
      click_link('new_post_from_nav')
    end
  end

  describe 'edit' do
    before do
      @post = FactoryGirl.create(:post)
    end

    it 'can be reached by clicking edit on index page' do
      visit posts_path
      click_link("edit_#{@post.id}")

      expect(page.status_code).to eq(200)
    end

    it 'can be edited from a form page successfully' do
      visit edit_post_path(@post)
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'Some edited rationale'
      click_on 'Save'

      expect(page).to have_content('Some edited rationale')
    end
  end
end