class User < TimeclockRecord

  # Enumerations.
  enum access_level: {
    employee: 1,
    supervisor: 2,
    admin: 3
  }

  # Relationships.
  has_many  :blocks,
            dependent:  :restrict_with_error

  # Scopes.
  scope :by_number, -> { order(:employee_number) }

  # Callbacks.

  # Instance methods.

  # Returns employee number and name.
  def number_and_name
    "<span class=\"operator\"><strong>#{self.employee_number}</strong> #{self.name}</span>".html_safe
  end

  # Authenticates via System i.
  def ibm_authenticate(password)
    uri = URI.parse("http://as400api.varland.com/v1/as400_auth")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)
    request.body = "username=#{self.username}&password=#{password}"
    response = http.request(request)
    return false unless response.code.to_s == '200'
    result = JSON.parse(response.body)
    return result
  end

  # Class methods.

  # Returns collection of user objects for dropdown.
  def self.for_dropdown(id)
    User.where(id: id).by_number.map {|u| ["#{u.employee_number} – #{u.name}", u.id]}
  end

end