class Raid < ActiveRecord::Base
  belongs_to :location
  has_many :child_labours
  has_many :community_farms

  def community_farm_status
    return 'Pending' if community_farms.blank?
    return 'Pending' if community_farms.first.involve_member.blank?
    'Completed'
  end

  def community_farm_blank?
    return true if community_farms.blank?
    false
  end

  def child_labours_count
    child_labours.where(is_deleted: false).count
  end

  def child_labours_blank?
    return true if child_labours.blank?
    false
  end

  def employer_name
    return '-' if child_labours.first.blank?
    child_labours.first.employer.full_name
  end

  def employers
    id = child_labours.first.employer.id if child_labours.first
    Employer.where(id: id, is_deleted: false)
  end
end
