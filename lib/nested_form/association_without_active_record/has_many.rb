module NestedForm
  module AssociationWithoutActiveRecord
    module HasMany
      def reflect_on_association(association)
        return nested_for_class.new if association == @nested_attribute

        raise StandardError, 'unexpected association name'
      end

      def nested_attribute(nested_attribute)
        @nested_attribute = nested_attribute
        define_method(:"#{nested_attribute}_attributes=") { true }
      end

      def nested_for_class_name(nested_for_class_name)
        raise 'Scope Not Accepted' unless nested_for_class_name.constantize

        @nested_for_class_name = nested_for_class_name
      end

      def nested_for_class
        raise 'nested_for_class_name Not Defined' if @nested_for_class_name.blank?

        @nested_for_class_name.constantize
      end
    end
  end
end
