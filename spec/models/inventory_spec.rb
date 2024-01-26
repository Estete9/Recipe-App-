require 'rails_helper'

RSpec.describe Inventory, type: :model do
  it 'is valid with valid attributes' do
    inventory = build(:inventory)
    expect(inventory).to be_valid
  end

   it 'is not valid without a name' do
    inventory = build(:inventory, name: nil)
    expect(inventory).to_not be_valid
  end
end
