require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do

  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  feature "They navigate to product page" do

    scenario "It Has a Quantity within the page" do 
      visit root_path
      
      first('article.product h4').click
      
      expect(page).to have_content("Quantity")
      # save_screenshot
    end

    scenario "It Will not have the Add button" do
      visit root_path
    
      first('article.product h4').click
    
      expect(page).to_not have_content("Add")
      # save_screenshot
    end

  end

end
