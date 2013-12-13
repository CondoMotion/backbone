class PropertySerializer < ActiveModel::Serializer
  attributes :id, :name, :signup_password, :company_id, :url, :subdomain
  # has_many :comments
  # embed :ids, include: true
  # delegate :current_user, to: :scope
  
  def url
    api_v1_property_url(object)
  end

  def subdomain
    object.subdomain.name
  end
  
  # def attributes
  #   data = super
  #   data[:edit_url] = edit_article_url(object) if current_user.admin?
  #   data
  # end
end