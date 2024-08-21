def stock_picker(prices)
  buy_index = sell_index = max_profit = 0

  prices.each_with_index do |buy_price, i|
    prices[i..].each_with_index do |sell_price, j|
      next unless sell_price - buy_price > max_profit

      buy_index = i
      sell_index = j + i
      max_profit = sell_price - buy_price
    end
  end

  [buy_index, sell_index, max_profit]
end

prices = [17, 3, 6, 9, 15, 8, 6, 1, 10]
buy, sell, profit = stock_picker(prices)
puts "Buy on day #{buy} and sell on day #{sell} for a profit of #{profit}"
