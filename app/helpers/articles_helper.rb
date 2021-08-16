module ArticlesHelper
  #add methods here which we use in our views
  def persisted_comments(comments)
    #we only want comments that come from the db, not the ones that are being created that are new
    comments.reject { |comment| comment.new_record? }
  end

end
