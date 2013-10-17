module ProfitsHelper
	def self.set_to_currency _i
		return '' if _i == nil
		i = _i.abs

		copper = i % 100
		i /= 100
		silver = i % 100
		i /= 100
		gold = i

		return (_i 	< 0 ? '-' : ' ')				+
			(gold 	> 0 ? 
				(gold > 9 ? 
					"#{gold}G " : " #{gold}G " 	
				) : '    '
			)										+
			(silver > 0 ? 
				(silver > 9 ?
					"#{silver}S " : " #{silver}S "
				) : 
				(gold > 0 ?
					" 0S " : '    ')
			)										+
				(copper > 9 ? 
					"#{copper}C" : " #{copper}C")
	end
end
