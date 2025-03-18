class User::UsersController < ApplicationController
  def search
    @users = User.where("title ILIKE ?", "%#{params[:user_search]}%").order(account_type: :desc)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update("search_results",
                              partial: "users/search_results",
                              locals: { users: @users })
        ]
      end
    end
  end
end
