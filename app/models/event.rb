class Event < ActiveRecord::Base
  belongs_to :user
  has_many:comments,dependent: :delete_all
  has_many:joins, dependent: :delete_all
  has_many:joiners,through: :joins, source: :user

  validates :name, :date, :city, :state, presence: true
  validate :validate_date

  private

  def validate_date
      if date.present? && date < DateTime.now.to_date
          errors.add(:date, 'Event date must be a future date')
      end
  end
end
