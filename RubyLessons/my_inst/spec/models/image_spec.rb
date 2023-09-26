require 'rails_helper'

RSpec.describe Image, type: :model do
  describe 'associations' do
    it 'belongs to an imageable object' do
      association = Image.reflect_on_association(:imageable)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe 'attached photos' do
    it 'can have many attached photos' do
      image = create(:image, photos_count: 3)
      expect(image.photos.count).to eq(3)
    end
  end
end
