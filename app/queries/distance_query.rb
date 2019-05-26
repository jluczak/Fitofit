class DistanceQuery
  def self.weekly_distance(relation: Activity)
    relation
      .where('created_at > ?', 7.days.ago)
      .sum(:distance)
      .round(2)
  end

  def self.monthly_statistics(relation: Activity)
    relation
      .group_by_month(:created_at, last: 1)
      .group_by_day(:created_at, format: '%d. %B')
      .sum(:distance)
  end
end
