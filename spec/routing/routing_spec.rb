# frozen_string_literal: true

require 'spec_helper'

describe 'check routes for application' do
  it 'routes/ to home#index' do
    expect(get: '/').to route_to(
      controller: 'home',
      action: 'index'
    )
  end

  it 'routes ' do
    expect(get: '/posts').to route_to(
      controller: 'posts',
      action: 'index'
    )
  end

  it 'routes ' do
    expect(post: '/posts').to route_to(
      controller: 'posts',
      action: 'create'
    )
  end
end
