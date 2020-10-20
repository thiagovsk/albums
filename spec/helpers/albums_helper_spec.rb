require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the AlbumsHelper. For example:
#
# describe AlbumsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe AlbumsHelper, type: :helper do
  describe 'artists_select' do
    it 'returns a list of artists name' do
      expect(helper.artists_select).to include(['Justin Bieber'])
    end
  end
end
