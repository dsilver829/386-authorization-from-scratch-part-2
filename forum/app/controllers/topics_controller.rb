class TopicsController < ApplicationController
  def index
    @topics = Topic.order("sticky desc")
  end

  def show
    @topic = current_resource
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user = current_user
    if @topic.save
      redirect_to @topic, notice: "Created topic."
    else
      render :new
    end
  end

  def edit
    @topic = current_resource
  end

  def update
    @topic = current_resource
    if @topic.update_attributes(topic_params)
      redirect_to topics_url, notice: "Updated topic."
    else
      render :edit
    end
  end

  def destroy
    @topic = current_resource
    @topic.destroy
    redirect_to topics_url, notice: "Destroyed topic."
  end

private

  def topic_params
    params.require(:topic).permit(:name, :sticky)
  end

	def current_resource
		@current_resource ||= Topic.find(params[:id]) if params[:id]
	end
end
