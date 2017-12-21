module BlocRecord
   module Utility
 #   #1 -- Makes it so this will be a class method instead of an instance method
     extend self

     def underscore(camel_cased_word)
 #      #2 -- replaces any double colons with a slash
        string = camel_cased_word.gsub(/::/, '/')
 #      #3 -- inserts an underscore between any all-caps class prefixes (like acronyms) and other words
        string.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
 #      #4 --  inserts an underscore between any camelcased words
        string.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
 #      #5 -- replaces any - with _ using tr
        string.tr!("-", "_")
 #      #6 -- makes the string lowercase
        string.downcase
     end

     def sql_strings(value)
       case value
       when String
         "'#{value}'"
       when Numeric
         value.to_s
       else
         "null"
       end
     end

     def convert_keys(options)
       options.keys.each {|k| options[k.to_s] = options.delete(k) if k.kind_of?(Symbol)}
       options
     end

     def instance_variables_to_hash(obj)
       Hash[obj.instance_variables.map{ |var| ["#{var.to_s.delete('@')}", obj.instance_variable_get(var.to_s)]}]
     end

     def reload_obj(dirty_obj)
       persisted_obj = dirty_obj.class.find_one(dirty_obj.id)
       dirty_obj.instance_variables.each do |instance_variable|
         dirty_obj.instance_variable_set(instance_variable, persisted_obj.instance_variable_get(instance_variable))
       end
     end

   end
end
