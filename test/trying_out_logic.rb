def get_avaliable_scores(selected_score)
    s = selected_score.to_i
    @scores_to_display = []
    (s..10).each do |i|
    @scores_to_display << i.to_s
    end
end


get_avaliable_scores("2")
