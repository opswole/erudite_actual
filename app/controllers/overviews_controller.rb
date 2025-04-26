class OverviewsController < ApplicationController
  before_action :set_user
  def index
    @units = @user.units

    # @units = Unit.includes(topics: :messages).where(id: unit_ids)

    @fake_messages = @units.map do |unit|
      Faker::Lorem.sentence(word_count: 10)
    end

    @recent_mentions = @user.mentions
                            .includes(message: [ :user, messageable: [ :unit ] ])
                            .order(created_at: :desc)
                            .limit(20)
    @assignments = @user.assignments
  end

  private
  def set_user
   @user = Current.user
  end
end
