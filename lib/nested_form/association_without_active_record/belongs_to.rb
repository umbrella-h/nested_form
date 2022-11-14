module NestedForm
  module AssociationWithoutActiveRecord
    module BelongsTo
      def persisted?
        id.present?
      end

      def klass
        self.class
      end
    end
  end
end
