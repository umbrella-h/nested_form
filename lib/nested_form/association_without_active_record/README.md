# About AssociationWithoutActiveRecord module

My team decoupled some features with ActiveRecord when turning our legacy system into DDD-oriented. Before migrating to another useful substitute, I tried to make the gem applied to entities which are non-ActiveRecord-based as well. 

Take `Book` and `Chapter` for example:\
(It's OK if not using `Dry::Struct`. Just make sure that `chapter.id` is available)

```ruby
class Book < Dry::Struct
  extend NestedForm::AssociationWithoutActiveRecord::HasMany
  nested_for_class_name 'Chapter'
  nested_attribute :chapters

  attribute :id,                    Types::Coercible::Integer.optional.default(nil)
  attribute :title,                 Types::Coercible::String.optional.default(nil)
  attribute :chapters,              Types::Strict::Array.of(Chapter).optional.default([].freeze)
end
```
```ruby
class Chapter < Dry::Struct
  include NestedForm::AssociationWithoutActiveRecord::BelongsTo

  attribute :id,                  Types::Coercible::Integer.optional.default(nil)
  attribute :number_of_pages,     Types::Coercible::Integer.optional.default(0)
  attribute :annotation,          Types::Coercible::String.optional.default(nil)
  attribute :_destroy,            Types::Coercible::Bool.default(false)
end
```