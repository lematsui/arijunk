class MemesController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index, :show]

	def index
		set_time
		epic_dropdown
		@time_to_take = Time.now - @time
		@memes = Meme.where(date: @time_to_take..Time.now).order(total_votes: :desc)
	end

	def show
		@meme = Meme.find(params[:id])
		@votes = @meme.upvotes - @meme.downvotes
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
    @meme.total_votes = 0
		extract_tags
		@meme.tags = @tags
		if @meme.save
			redirect_to meme_path(@meme)
		else
			render :new
		end
	end

	def upvote
		meme = Meme.find(params[:meme][:id])
		meme.upvotes += 1
    meme.total_votes = meme.upvotes - meme.downvotes
    meme.save
    u = current_user
    u.voted.delete([meme.id.to_s, "down"]) if u.voted.include?([meme.id.to_s, "down"])
    u.voted << [meme.id, "up"]
    u.save
	end

  def remove_upvote
    meme = Meme.find(params[:meme][:id])
    meme.upvotes -= 1
    meme.total_votes = meme.upvotes - meme.downvotes
    meme.save
    u = current_user
    u.voted.delete([meme.id.to_s, "up"]) if u.voted.include?([meme.id.to_s, "up"])
    u.save
  end

	def downvote
		meme = Meme.find(params[:meme][:id])
		meme.downvotes += 1
    meme.total_votes = meme.upvotes - meme.downvotes
		meme.save
    u = current_user
    u.voted.delete([meme.id.to_s, "up"]) if u.voted.include?([meme.id.to_s, "up"])
    u.voted << [meme.id, "down"]
    u.save
	end

  def remove_downvote
    meme = Meme.find(params[:meme][:id])
    meme.downvotes -= 1
    meme.total_votes = meme.upvotes - meme.downvotes
    meme.save
    u = current_user
    u.voted.delete([meme.id.to_s, "down"]) if u.voted.include?([meme.id.to_s, "down"])
    u.save
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
