require 'rails_helper'

RSpec.describe 'inventories/show', type: :view do
  before(:each) do
    assign(:inventory, Inventory.create!(
                         name: 'Name',
                         user: nil
                       ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
  end
end
