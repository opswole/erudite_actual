class User::OverviewsController < ApplicationController
  before_action :set_user
  def index
    @units = @user.units

    # @units = Unit.includes(topics: :messages).where(id: unit_ids)

    @fake_messages = @units.map do |unit|
      Faker::Lorem.sentence(word_count: 10)
    end

    @recent_mentions = @user.mentioned_messages.includes(topic: :unit)
  end

  private
  def set_user
   @user = Current.user
  end
end
