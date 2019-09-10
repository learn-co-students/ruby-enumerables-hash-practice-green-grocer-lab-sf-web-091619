def consolidate_cart(cart)
  final_hash = {}
  cart.each do |item|
    name = item.keys[0]
    props = item.values[0]
    
    if final_hash.has_key?(name)
      final_hash[name][:count] += 1
    else
      final_hash[name] = {
        price: props[:price],
        clearance: props[:clearance],
        count: 1
      }
    end
  end
  final_hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item = coupon[:item]
    if cart[item]
      if cart[item] && cart[item][:count] >= coupon[:num] && !cart.has_key?("#{item} W/COUPON")
        cart["#{item} W/COUPON"] = {
          price: coupon[:cost] / coupon[:num],
          clearance: cart[item][:clearance],
          count: coupon[:num]
        }
        cart[item][:count] -= coupon[:num]
      elsif cart[item][:count] >= coupon[:num] && cart["#{item} W/COUPON"]
        cart["#{item} W/COUPON"][:count] += coupon[:num]
        cart[item][:count] -= coupon[:num]
      end
    end 
  end
  cart
end

def apply_clearance(cart)
  # code here
  discount = 0.2
  cart.each do |name, props|
    if props[:clearance]
      props[:price] -= props[:price] * discount
    end
  end
  cart
end

def checkout(cart, coupons)
  final_cart = consolidate_cart(cart)
  discounts = apply_coupons(final_cart, coupons)
  clearance = apply_clearance(discounts)
  
  total = clearance.reduce(0) { |acc, (key, value)| 
    acc += value[:price] * value[:count]
  }
  
  if total > 100 
    total *= 0.9
    return total
  else
    return total
  end
end
