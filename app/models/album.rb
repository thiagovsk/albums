class Album < ApplicationRecord
  validates :artist, presence: true
end
