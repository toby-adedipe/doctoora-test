class CardsController < ApplicationController

	before_action :authenticate_admin!, except: [:show_category]

	def index
		@cards = Card.all
	end

	def new
		@card = Card.new
		@categories = CardCategory.all.map(&:name)
	end
	
	def create
		category = CardCategory.find_by_name(params[:card][:card_category])
		@card = category.cards.new(card_params)

		if @card.save
			flash[:notice] = "Card created"
			redirect_to cards_path
		else
			flash[:notice] = "Problem creating card"
			render 'new'
		end
	end

	def show_category
		@category = CardCategory.find(params[:id])
		@cards = @category.cards.all
	end

	def edit
		@card = Card.find(params[:id])
		@categories = CardCategory.all.map(&:name)
	end

	def update
		@card = Card.find(params[:id])
		@card.update(card_params)

		redirect_to cards_path
	end

	def destroy
		@card = Card.find(params[:id])
		@card.destroy
		flash[:notice] = "Card deleted successfully"
		redirect_to cards_path
	end

	private

	def card_params
		params.require(:card).permit(:link, :title, :body, :image, :page, :video_url)
	end

end