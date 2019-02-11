require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  describe 'gravatar_for' do
    let(:user) { create(:user) }
    let(:gravatar_id) { Digest::MD5::hexdigest(user.email) }
    let(:gravatar_url) { "https://secure.gravatar.com/avatar/#{gravatar_id}?s=80" }

    it "returns a string with image tag" do
      expect(gravatar_for(user)).to match(/<img.*>/)
    end

    it "has an exact src url" do
      expect(gravatar_for(user)).to include(gravatar_url)
    end
  end
end
