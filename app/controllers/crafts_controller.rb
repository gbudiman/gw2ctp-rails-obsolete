class CraftsController < ApplicationController
	def drillthrough
		@crafts = Array.new
		@tree = params[:id].split('-')
		@depth = @tree.length
		@regrow = @tree.join('-')
		seek_id = @tree[-1]

		components = Craft.find(:all, conditions: "final_id = #{seek_id}")
		time = Market.maximum :time

		components.each do |component|
			p = Profit.find_by_id(component.comp_id) || Hash.new
			m = Market.find_by_item_id_and_time(component.comp_id, time) || Hash.new
			i = Item.find_by_id(component.comp_id)

			r = {
				:id				=> component.comp_id,
				:crafting_amt 	=> fix_width(component.comp_amt, @depth),
				:name			=> p[:name] || i[:name],
				:crafting_cost	=> p[:crafting_cost],
				:sell_price		=> p[:sell_price] || m[:sell_price],
				:profit_on_sell => p[:crafting_profit_on_sell],
				:sell_count		=> p[:sell_count] || m[:sell_count],
				:buy_price		=> p[:buy_price] || m[:buy_price],
				:profit_on_buy	=> p[:crafting_profit_on_buy],
				:buy_count		=> p[:buy_count] || m[:buy_count],
			}

			if r[:crafting_cost] == nil
				r[:sell_class] = 'path_highlight'
			elsif r[:sell_price] == nil
				if r[:crafting_cost] != nil
					r[:craft_class] = 'path_highlight'
				end
			elsif r[:crafting_cost] > r[:sell_price]
				r[:sell_class] = 'path_highlight' 
			else
				r[:craft_class] = 'path_highlight'
			end

			@crafts.push r
		end

		render partial: 'crafts/drillthrough', object: @crafts
	end

	def fix_width _i, _depth
		length = _i.to_s.length
		space = ' ' * (3 - length)
		lead = ' ' * 5 * (_depth - 1)
		return "#{lead}(#{space}#{_i})"
	end
end
