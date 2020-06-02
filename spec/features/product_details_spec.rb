require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    3.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They click on a product" do
    # ACT
    visit root_path
    puts page.html
    find("footer[data-cta_id='1']").click_link('Details »')
    

    # DEBUG
    save_screenshot

    # VERIFY
    expect(page).to have_css 'article.product'
    puts page.html
  end

end
