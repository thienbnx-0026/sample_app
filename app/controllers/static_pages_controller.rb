class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.create_desc.page(params[:page])
                                .per_page Settings.paginate_post
    end
  end

  def help; end

  def about; end
end
