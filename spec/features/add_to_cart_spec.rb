require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'
    @user = User.create!(first_name: 'test', last_name: 'test', email: 'test', password: 'password',password_confirmation: 'password')

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
    page.find('.btn-primary', match: :first).click
    fill_in 'email', with: 'test'
    fill_in 'password', with: "password"
    click_button "Submit"

    # VERIFY
    expect(page).to have_link 'My Cart (0)', href: '/cart'

    # ACT
    page.find('.btn-primary', match: :first).click

    # VERIFY
    expect(page).to have_link 'My Cart (1)', href: '/cart'

    # DEBUG
    save_screenshot
  end

end
