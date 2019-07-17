class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    relationship = Relationship.find_by id: params[:id]

    if relationship
      @user = relationship.followed
      current_user.follow(@user)
    end
    respond_to do |format|
      format.html{redirect_to @user}

      if relationship.nil?
        format.js{flash.now[:danger] = t("user_not_found")}
      else
        format.js{flash.now[:message] = "#{t("follow")} #{@user.name}"}
      end
    end
  end

  def destroy
    relationship = Relationship.find_by id: params[:id]

    if relationship
      @user = relationship.followed
      current_user.unfollow(@user)
    end
    respond_to do |format|
      format.html{redirect_to @user}

      if relationship.nil?
        format.js{flash.now[:danger] = t("user_not_found")}
      else
        format.js{flash.now[:message] = "#{t("unfollow")} #{@user.name}"}
      end
    end
  end
end
