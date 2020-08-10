class Xray < ApplicationRecord

  # Relationships.
  has_many  :blocks,
            dependent:  :restrict_with_error

  # Scopes.

  # Callbacks.

  # Instance methods.

  # Returns ID and description.
  def id_and_description
    "<code>##{self.id}</code> #{self.description}"
  end

end