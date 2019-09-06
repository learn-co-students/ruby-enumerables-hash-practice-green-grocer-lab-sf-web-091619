require 'pry'

def consolidate_cart(cart)
  new_cart = {}
    cart.each do |items|
    items.each do |name, attribute|
      if new_cart[name]
        new_cart[name][:count] += 1
      else
        new_cart[name] = attribute
        new_cart[name][:count] = 1
      end
    end
  end
new_cart
end



def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item = coupon[:item]
    coupon_item = "#{item} W/COUPON"
    if cart[item]
      if cart[item][:count] >= coupon[:num] && !cart[coupon_item]
        cart[coupon_item] = {price: coupon[:cost] / coupon[:num], clearance: cart[item][:clearance], count: coupon[:num]}
        cart[item][:count] -= coupon[:num]
      elsif cart[item][:count] >= coupon[:num] && cart[coupon_item]
        cart[coupon_item][:count] += coupon[:num]
        cart[item][:count] -= coupon[:num]
      end
    end
  end
  cart
end



def apply_clearance(cart)
  cart.each do |item, stats|
    if stats[:clearance]
      stats[:price] -= stats[:price] * 0.2
    end
  end
  cart
end



def checkout(cart, coupons)
  final_cart = consolidate_cart(cart)
  apply_coupons(final_cart, coupons)
  apply_clearance(final_cart)
  total = 0
  final_cart.each do |item, stats|
    total += (stats[:price] * stats[:count])
  end
if total >= 100
    total *= 0.9
  end
  total
end
