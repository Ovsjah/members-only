require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#full_title' do
    it "returns a default title" do
      expect(helper.full_title).to eq("Members Only")
    end

    it "returns a full title" do
      expect(helper.full_title('About')).to eq("About | Members Only")
    end
  end
end
