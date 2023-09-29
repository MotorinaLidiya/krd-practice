require 'rails_helper'

RSpec.describe Subscribtion, type: :model do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  before(:each) do
    @subscribtion = Subscribtion.new(owner: user1, subscriber: user2)
  end

  it 'is valid' do
    expect(@subscribtion).to be_valid
  end

  it 'requires owner' do
    @subscribtion.owner = nil
    expect(@subscribtion).not_to be_valid
  end

  it 'requires subscriber' do
    @subscribtion.subscriber = nil
    expect(@subscribtion).not_to be_valid
  end

  it 'enforces uniqueness of subscriber within scope of owner' do
    duplicate_subscribtion = @subscribtion.dup
    @subscribtion.save
    expect(duplicate_subscribtion).not_to be_valid
  end
end
