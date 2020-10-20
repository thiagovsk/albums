require 'rails_helper'

RSpec.describe Albums::ListArtists do
  subject(:response) { described_class.call }

  describe '.call' do
    it 'returns list of artists' do
      expect(response['1'].keys).to eq(%w[id twitter name])
    end
  end
end
