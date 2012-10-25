module MembersHelper
  def members_rating all=false
    members = Member.order("rating desc").includes("votes")
    members = members.limit(10) unless all
    members
  end
end
