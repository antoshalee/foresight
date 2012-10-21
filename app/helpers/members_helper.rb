module MembersHelper
  def members_rating_with_current_user_votes
    Member.order("rating desc").includes("votes").where("votes.user_id=?",current_user.id)
  end
end
