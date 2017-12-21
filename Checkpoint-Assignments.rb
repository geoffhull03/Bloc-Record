#Write a Ruby method that converts snake_case to CamelCase using regular expressions (you can test them on Rubular).
#Send your code to your mentor.
def snake_to_camel(snake_string)
  string = snake_string.gsub(/(_[a-z])/) {|match| match[1].upcase}
  string
end

def find_by(contact, contact_id)
  results = connection.execute <<-SQL
    SELECT #{contact} FROM #{table}
    WHERE contact_id = #{contact_id}
  SQL
  results
end

def find_each(hash)
  rows = connection.execute <<-SQL
    SELECT * FROM #{table}
    ORDER BY #{table}.id
    LIMIT #{hash[:batch_size]}
    OFFSET #{hash[:start]}
  SQL

  current_row_index = 0
  while current_row_index <= rows.length - 1
    yield rows[current_row_index]
    current_row_index += 1
  end
end

def find_in_batches(hash)

  rows = connection.execute <<-SQL
    SELECT #{columns.join(",")} FROM #{table}
    WHERE id = #{hash[:start]} LIMIT #{hash[:batch_size]}
  SQL

  yield rows
end
