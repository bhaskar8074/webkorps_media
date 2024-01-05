# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    User.new(
      email: 'present@test.com',
      password: '123456'
    )
  end

  it 'has many posts' do
    expect(user).to respond_to(:posts)
  end

  context 'when user try to create post' do
    post = user.posts.build(caption: 'hiii', post_img: 'faker.jdfjl')
    it 'can create a post' do 
      expect(post).to be_instance_of(Post)
      expect(post.user).to eq(user)
    end
  end

  context 'valid Factory' do
    it 'has a valid factory' do
      expect(build(:user)).to be_valid
    end
  end

  describe 'validations' do
    context 'presence' do
      it 'should have an email' do
        user.email = ''
        expect(user).to_not be_valid
      end

      it 'should have an password' do
        user.password = ''
        expect(user).to_not be_valid
      end

      it 'should have minimum 6 chars' do
        user.password = '1234'
        expect(user).to_not be_valid
      end
    end
  end
end
