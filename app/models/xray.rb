class Xray < ApplicationRecord

  # Relationships.
  has_many  :blocks,
            dependent:  :restrict_with_error

  # Scopes.

  # Callbacks.

end