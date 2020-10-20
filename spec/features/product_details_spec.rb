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

  feature "A User can navigate to product page" do

    scenario "By clicking details button, it will navigate to product page" do
      visit root_path

      first('article.product').find_link('Details').click

      expect(page).to have_css '.product-detail'
    end

    scenario "By clicking product image, it will navigate to product page" do
      visit root_path

      first('.product header img').click

      expect(page).to have_css '.product-detail'
    end

    scenario "By clicking product title, it will navigate to product page" do 
      visit root_path
      
      first('article.product h4').click
      
      expect(page).to have_css '.product-detail'
    end

    scenario "On the product page, it will have the product 'Quantity' " do
      visit root_path
    
      first('article.product h4').click
    
      expect(page).to have_content("Quantity")
      expect(page).to have_css '.product-detail'
    end

    scenario "On the product page, it will not have the 'Add' button" do
      visit root_path
    
      first('article.product h4').click
    
      expect(page).to_not have_content("Add")
      expect(page).to have_css '.product-detail'
    end

  end

end
