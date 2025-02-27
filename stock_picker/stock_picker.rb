# frozen_string_literal: true

def stock_picker(prices)
  min_price = prices[0]
  min_index = 0
  max_profit = 0
  buy_index = 0
  sell_index = 0

  prices.each_with_index do |price, index|
    if price < min_price
      min_price = price
      min_index = index
    end

    profit = price - min_price

    next unless profit > max_profit

    max_profit = profit
    buy_index = min_index
    sell_index = index
  end

  [buy_index, sell_index]
end

prices = [17, 3, 6, 9, 15, 8, 6, 1, 10]
puts stock_picker(prices)
