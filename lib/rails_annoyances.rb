require "rails_annoyances/version"

module RailsAnnoyances
end

module ActiveRecord
  module Core
    extend ActiveSupport::Concern
    module ClassMethods
      def inspect
        if self == Base
          super
        elsif abstract_class?
          "#{super}(abstract)"
        elsif !connected?
          if Rails.const_defined? 'Console'
            super.constantize.connection
            attr_list(super)
          elsif Rails.const_defined? 'Server'
            raise "#{super} (No DB Connection)"
          end
        elsif table_exists?
          attr_list(super)
        else
          "#{super}(Table doesn't exist)"
        end
      end

      def attr_list(obj)
        attr_list = columns.map { |c| "#{c.name}: #{c.type}" } * ', '
        "#{obj}(#{attr_list})"
      end
    end
  end
end
