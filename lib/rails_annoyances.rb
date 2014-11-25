require "rails_annoyances/version"

module RailsAnnoyances
end

module ActiveRecord
  module Core
    extend ActiveSupport::Concern
    module ClassMethods
      # Monkeypatch - Eliminates the need to run Model.connection in Rails console.
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
            "#{super} (call '#{super}.connection' to establish a connection)"
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

# Auto reload codebase if an exception is found since you're probably working and saving new code with a console open.
begin
rescue Exception
  unless reload!
    raise
  end
end

class ReverseEngineer

  # Filters Methods tell you all the filters running on your methods
  # Props to @ScottWB for portions of this code 
  # https://gist.github.com/scottwb/1851142
  def self.filters(kind = nil)
    call = caller.first
    controller = call.match("(?<=controllers\/)(.*)(?=.rb)")[0].camelcase.constantize
    action = call.match("(?<=:in `)(.*)(?=')")[0]
    all_filters = controller._process_action_callbacks
    all_filters = all_filters.select{|f| f.kind == kind} if kind
    all_filters = all_filters.select{|f| f if (f.inspect.to_s.include?(action.to_s) || f.inspect.to_s.include?("@if=[]") ) }
    Rails.logger.debug "#{kind.to_s.capitalize} Filters:"
    Rails.logger.debug all_filters.map(&:filter)
  end
 
  def self.before_filters
    filters(:before)
  end
 
  def self.after_filters
    filters(:after)
  end
 
  def self.around_filters
    filters(:around)
  end
end
