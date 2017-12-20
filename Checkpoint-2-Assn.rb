#Write a Ruby method that converts snake_case to CamelCase using regular expressions (you can test them on Rubular).
#Send your code to your mentor.
def snake_to_camel(snake_string)
  string = snake_string.gsub(/(_[a-z])/) {|match| match[1].upcase}
  string
end

#Add a select method which takes an attribute and value and searches for all records that match:
def find_by(attribute, value)
  results = connection.execute <<-SQL
    SELECT #{attribute} FROM #{table}
    WHERE value = #{value}

  SQL
  results
end
