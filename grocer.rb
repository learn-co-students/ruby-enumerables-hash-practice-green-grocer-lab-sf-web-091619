require 'pry'

def consolidate_cart(cart)
  # code here
  
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
  # code here
  
  coupons.each do |coupon|
    item = coupon[:item]
    
    if cart[item] &&
    
    binding.pry
  end
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
