class MemesController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index, :show]

	def index
		@memes = Meme.all
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
end
