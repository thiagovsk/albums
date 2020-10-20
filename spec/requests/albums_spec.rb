require 'rails_helper'

RSpec.describe '/albums', type: :request do
  let(:current_user) { create(:user) }

  let(:valid_attributes) do
    attributes_for(:album)
  end

  let(:invalid_attributes) do
    { album: nil, year: nil, artist: nil }
  end

  before do
    allow_any_instance_of(AlbumsController).to receive(:current_user).and_return(current_user)
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Album.create! valid_attributes
      get albums_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      album = Album.create! valid_attributes
      get album_url(album)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_album_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      album = Album.create! valid_attributes
      get edit_album_url(album)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Album' do
        expect do
          post albums_url, params: { album: valid_attributes }
        end.to change(Album, :count).by(1)
      end

      it 'redirects to the created album' do
        post albums_url, params: { album: valid_attributes }
        expect(response).to redirect_to(album_url(Album.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Album' do
        expect do
          post albums_url, params: { album: invalid_attributes }
        end.to change(Album, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post albums_url, params: { album: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        attributes_for(:album, year: '1111')
      end

      it 'updates the requested album' do
        album = Album.create! valid_attributes
        patch album_url(album), params: { album: new_attributes }
        album.reload
      end

      it 'redirects to the album' do
        album = Album.create! valid_attributes
        patch album_url(album), params: { album: new_attributes }
        album.reload
        expect(response).to redirect_to(album_url(album))
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        album = Album.create! valid_attributes
        patch album_url(album), params: { album: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested album' do
      album = Album.create! valid_attributes
      expect do
        delete album_url(album)
      end.to change(Album, :count).by(-1)
    end

    it 'redirects to the albums list' do
      album = Album.create! valid_attributes
      delete album_url(album)
      expect(response).to redirect_to(albums_url)
    end

    context 'when user have not access' do
      let(:current_user) { create(:user, role: 'user') }

      it 'raise error with CanCan::AccessDenied' do
        album = Album.create! valid_attributes
        expect do
          delete album_url(album)
        end.to raise_error(an_instance_of(CanCan::AccessDenied))
      end
    end
  end
end
