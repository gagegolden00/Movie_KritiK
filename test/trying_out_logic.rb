def get_avaliable_scores(selected_score)
    s = selected_score.to_i
    @scores = []
    (s..10).each do |i|
    @scores << i
    @scores_to_display = @scores.to_a
    end
end


get_avaliable_scores("2")
p @scores_to_display
