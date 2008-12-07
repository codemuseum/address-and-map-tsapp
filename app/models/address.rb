class Address < ActiveRecord::Base

  has_many :page_objects
  
  attr_protected :organization_uid
  validates_presence_of :organization_uid
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :organization_uid
  
  before_validation :add_link_protocol
  
  named_scope :all_for, lambda { |org_uid| {
    :conditions => { :organization_uid => org_uid }
  } }
  
  # Finds a duplicate address in the current org - all values exactly the same.  They obviously meant to use this.
  named_scope :duplicate_for, lambda { |org_uid, hash| {
    :conditions => { :organization_uid => org_uid,
      :name => hash[:name],
      :street_line1 => hash[:street_line1],
      :street_line2 => hash[:street_line2],
      :city => hash[:city],
      :state => hash[:state],
      :country => hash[:country],
      :zipcode => hash[:zipcode],
      :email => hash[:email],
      :phone => hash[:phone],
      :fax => hash[:fax],
      :link => hash[:link],
      :note => hash[:note]
    }
  } }
  
  def self.new_for_organization(org_uid, attrs = {})
    returning new(attrs) do |ak|
      ak.organization_uid = org_uid
    end
  end
  
  def blank?
      not (
        !name.blank? or
        !street_line1.blank? or
        !street_line2.blank? or
        !city.blank? or
        # state by itself is not meaningful
        !zipcode.blank? or
        !phone.blank? or
        !fax.blank? or
        !email.blank? or
        !link.blank?)
  end
  
  def new_and_blank?
    new_record? && blank?
  end
  
  def mappable?
    !city.blank? || !state.blank? || !zipcode.blank?
  end
  
  def location_s(use_street_2 = true)
    "" + 
    ( !street_line1.blank? ? street_line1 + ", " : "" ) +
      ( use_street_2 && !street_line2.blank? ? street_line2 + ", " : "" ) +
      ( !city.blank? ? city + ", " : "" ) +
      ( !state.blank? ? state : "" ) +
      ( !zipcode.blank? ? " #{zipcode}" : "" )
  end
  
  protected 
  
    def add_link_protocol
      self.link = 'http://' + self.link if self.link && !self.link.index('://')
    end
end
