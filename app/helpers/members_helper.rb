module MembersHelper
  def members_rating
    Member.order("rating desc").includes("votes")
  end
end
