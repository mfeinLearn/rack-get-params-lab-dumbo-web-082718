class Application
 ## @@items - class varable which stores an array of strings(food items)
  @@items = ["Apples","Carrots","Pears"]
  ## @@cart - class varable which stores an array of the items in your cart
  @@cart = []
##
##
# #call - everytime I make a request #call is called
#
  def call(env)
    # env is a hash with information about the request
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    #########
    ## the filter comes from the path method
    ##
    # Let's filter so that this only works
    # for the /items path using the #path
    # method of our Rack::Request object:

    # --- begining of /item/ ---
    # if the path matches /items do the following
    if req.path.match(/items/)
      # iterate through the @@items array
      @@items.each do |item|
        # print out/write the items on the website
        # esp.write outputs the item on the screen
        resp.write "#{item}\n"
      end
    #- if the path matches /search do the following
    # --- begining of /search/ ---
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)

      ## checking what items are in your cart out what is in your cart
      # --- begining of /cart/ ---
    elsif req.path.match(/cart/)
        search_term = req.params["q"]
        resp.write handle_search(search_term)
        ## #empty is an array method
        ## #empty returns true if the array is empty ([].empty?   #=> true)
        ##
        if @@cart.empty?
          ## the @@cart array is currently empty
          resp.write "Your cart is empty"
        else
          # iterate through the cart when it is not empty
          # and print out that item
          @@cart.each do |item|
            resp.write "#{item}\n"
          end
          # --- end of /cart/ ---
        end


      # add an item to your cart but check to see
      # if the item is in the items array first
      # --- begining of /add/ ---
    elsif req.path.match(/add/)
      item_to_add = req.params["item"]

      ## include? is an array method that checks the array that
      #the method is called to see if an item that is specified is in the
      ## array if true return true
      if @@items.include?(item_to_add)
        @@cart << item_to_add
        resp.write "added #{item_to_add}"
      else
        resp.write "We don't have that item!"
              # --- end of /add/ ---
      end

    else
      resp.write "Path Not Found"
      # --- end of // ---

      # --- end of /search/ ---
      # ---end of /item/---
    end


    resp.finish
    # in the call method (#call) we have to return back the responce
  end
#
# Exspected data type: returns the search_term(string) with "is one of our items" if that is found in our array
# if the search_term is found in our class varable @@items return "#{search_term} is one of our items"
# if the search term is not found in our array of items(@@items) return false i.e. "Couldn't find #{search_term}"
  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
