require 'pp'
class ProfitsController < ApplicationController
	def list
		case params[:order]
		when nil 
		 	order_syntax = 'crafting_profit_on_buy DESC'
		when 'profit_on_buy'
			order_syntax = 'crafting_profit_on_buy DESC'
		when 'profit_on_sell'
			order_syntax = 'crafting_profit_on_sell DESC'
		when 'buy_count'
			order_syntax = 'buy_count DESC'
		when 'sell_count'
			order_syntax = 'sell_count DESC'
		end

		@list = Kaminari.paginate_array(
				Profit.order(order_syntax)
			).page params[:page]
	end
end
