# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|

  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
#    if Movie.where("title = ?",movie[:title]) == nil
#    then
       pelicula = Movie.create
       pelicula.title        = movie[:title]
       pelicula.rating       = movie[:rating]
       pelicula.release_date = movie[:release_date]
       pelicula.save

#pelicula.save!
#    end
    # debugger


#if Movie.where("title = ?",movie[:title]) == nil then flunk "CACA" end

  end
  Movie.all.count.should == 10
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  flunk "Unimplemented"
end



#When /^(?:|I )check "([^"]*)"$/ do |field|
#  check(field)
#end
#
#When /^(?:|I )uncheck "([^"]*)"$/ do |field|
#  uncheck(field)
#end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  if uncheck == nil
  then
    rating_list.split(",").each do |unitem|
       step %Q{I check "ratings_#{unitem.strip}"}
    end
  else
    rating_list.split(",").each do |unitem|
       step %Q{I uncheck "ratings_#{unitem.strip}"}
    end
  end

end


Then /I should( not)? see movies with ratings: (.*)/ do |negative,rating_list|
  # enter step(s) to ensure that other movies are not visible
  rowcount=0
  if negative == nil
  then

    rating_list.split(",").each do |unitem|
#step %Q{I should see "#{unitem.strip}"}
#step %Q{the "tbody" field should contain "#{unitem.strip}"}
#    page.all('tbody#moviesbody').
     rowcount += Movie.where("rating = ?", unitem.strip).count
    end

    rowcount.should == page.all('tbody/tr').count #/ 2

  else
    rating_list.split(",").each do |unitem|
     rowcount += Movie.where("rating = ?", unitem.strip).count

#rating_list.split(",").each do |unitem|
#step %Q{I should not see "#{unitem.strip}"}
#step %Q{the "moviesbody" field should not contain "#{unitem.strip}"}
    end
    
    (Movie.all.count - rowcount).should == page.all('tbody/tr').count #/ 2

  end
end
#  And I should not see movies with ratings PG-13, NC-17, G


#Then /I should see no movies/ do 
#  if false #asdf1 == "every"
#  then
#    Movie.all.count.should == page.all('tbody/tr').count
#  else
#    page.all('tbody/tr').count.should == 0
#  end
#end


Then /I should see all of the movies/ do
#debugger
     Movie.all.count.should == page.all('tbody/tr').count
end






Then /I should see '(.*)' before '(.*)'/ do |title1,title2|
#page.body.matches(/.*#{title1}.*#{title2}.*/)
  page.body.index(title1).should < page.body.index(title2)
end

