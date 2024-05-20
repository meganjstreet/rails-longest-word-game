require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "Putting in a random word with letters not from grid gives us a message that the word is not in the grid" do
    visit new_url
    assert test: "Random word"
    fill_in "word", with: "xylophone"
    click_on "Play"
    assert_text "Sorry but XYLOPHONE can't be built"
  end

  test "Putting in an invalid word gives us a message that the word is not a valid English word" do
    visit new_url
    assert test: "Invalid word"
    fill_in "word", with: "eqz"
    click_on "Play"
    assert_text "Sorry but EQZ does not seem to be a valid English word..."
  end
  # test "Putting in a valid english word gives us a message that the word is valid English word" do
  #   visit new_url
  #   assert test: "Invalid word"
  #   fill_in "word", with: ""
  #   click_on "Play"
  #   assert_text "Sorry but EQZ does not seem to be a valid English word..."
  # end
end
