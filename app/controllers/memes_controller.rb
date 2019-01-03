class MemesController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index, :show]

	def index
	end

	def show
	end

	def new
		@meme = Meme.new
	end

	def create
		@meme = Meme.new(meme_params)
	end

	private

	def meme_params
  	params.require(:meme).permit(:photo, :caption, :tags, :title)
	end
end
