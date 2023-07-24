require "test_helper"

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  test "review creation should fail" do
    puts "* testing review creation *"

    review = Review.new
    assert_not review.save, "Saved the review without content or score"

    review = Review.new(content: "test content")
    assert_not review.save, "saved the review with content but no score"

    review = Review.new(score: "1")
    assert_not review.save, "saved the review with score"

    review = Review.new(content: "test content", score: "1")
    assert_not review.save, "saved the review with content and score without a movie"

  end
  
end
