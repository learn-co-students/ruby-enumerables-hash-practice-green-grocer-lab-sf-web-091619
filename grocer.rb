def consolidate_cart(cart)
  new_cart = {}
  cart.each do |item| 
    item.each do |name,description|
      if new_cart[name]
        new_cart[name][:count] += 1
        
    else
      new_cart[name]=description
      new_cart[name][:count] = 1
    end
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
    coupons.each do |coupon|
    item = coupon[:item]
    if cart[item] 
      if cart[item][:count] >= coupon[:num] && !cart["#{item} W/COUPON"]
      
      cart["#{item} W/COUPON"]={:price => coupon[:cost]/coupon[:num],:clearance => cart[item][:clearance],:count => coupon[:num]}
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
  cart.each do |product_name, stats|
    stats[:price] -= stats[:price] * 0.20 if stats[:clearance] == true
  end
  cart
end

def checkout(array,coupons)
  hashed_cart = consolidate_cart(array)
  coupons_applied = apply_coupons(hashed_cart, coupons)
  clearance_applied = apply_clearance(coupons_applied)
total = clearance_applied.reduce(0){ |acc, (key, value)| acc +=  value[:price] * value[:count] }
if total > 100 
  return total * 0.9 
end
total
end
