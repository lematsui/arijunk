class MemesController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index, :show]

	def index
		set_time
		epic_dropdown
		@time_to_take = Time.now - @time
		@memes = Meme.where(date: @time_to_take..Time.now)
	end

	def show
		@meme = Meme.find(params[:id])
	end

	def new
		@meme = Meme.new
	end

	def create
		@meme = Meme.new(meme_params)
		@meme.user = current_user
		@meme.date = Time.now
		@meme.upvotes = 0
		@meme.downvotes = 0
		extract_tags
		@meme.tags = @tags
		if @meme.save
			redirect_to meme_path(@meme)
		else
			render :new
		end
	end

	private

	def meme_params
  	params.require(:meme).permit(:photo, :caption, :title)
	end

	def extract_tags
		@tags = []
		params[:meme][:tags][1..-1].each do |tag|
			@tags << Tag.find(tag.to_i)
		end
	end

	def set_time
		@time = params[:time].to_i
		@time = 24.hours if @time == 0
	end

	def epic_dropdown
		@dropdown_options = [[24.hours, "24 HOURS"],
												[1.week, "WEEK"], [1.month, "MONTH"],
												[1.year, "YEAR"]]
	end
end
