require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'
require './lib/round'
require './lib/turn'


class RoundTest < Minitest::Test

  def setup
    @card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    @card_2 = Card.new("Music is composed of what?", "Notes", :STEM)
    @cards = [@card_1, @card_2]
    @deck = Deck.new(@cards)
    @round = Round.new(@deck)
  end

  def test_round_exists
    assert_instance_of Round, @round
  end

  def test_round_deck
    assert_equal @deck, @round.deck
  end

  def test_turns
    assert_equal [], @round.turns
  end

  def test_current_card
    assert_equal @card_1, @round.current_card
  end

  def test_take_turn
    new_turn = @round.take_turn("Juneau")
    assert_instance_of Turn , new_turn
    assert_equal [new_turn], @round.turns
  end

  def test_number_correct
    @round.take_turn("Juneau")
    assert_equal 1, @round.number_correct
  end

  def test_number_correct_by_category
    @round.take_turn("Juneau")
    @round.number_correct_by_category(:Geography)
    assert_equal 1, @round.number_correct_by_category(:Geography)
  end

  def test_percent_correct
    @round.take_turn("Juneau")
    assert_equal 100.0, @round.percent_correct
    @round.take_turn("Wrong answer")
    assert_equal 50.0, @round.percent_correct
  end

  def test_percent_correct_by_category
    @round.take_turn("Juneau")
    assert_equal 100.0, @round.percent_correct_by_category(:Geography)
    @round.take_turn("Wrong Answer")
    assert_equal 0.0, @round.percent_correct_by_category(:STEM)
  end
end
