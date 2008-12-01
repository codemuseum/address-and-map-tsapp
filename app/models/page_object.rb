class PageObject < ActiveRecord::Base
  include ThriveSmartObjectMethods
  self.caching_default = :any_page_update #[in :forever, :page_update, :any_page_update, 'data_update[datetimes]', :never, 'interval[5]']

  belongs_to :address
  attr_protected :address_id
  
  after_update :save_address
  
  
  def validate
    unless address.valid?
      errors.add(:address, " has an error that must be corrected.")
    end
  end
  
  def all_addresses
    Address.all_for(self.organization_uid).map { |a| [a.name, a.id] }
  end
  
  # Find the right address 
  def assigned_address=(h)
    self.address = !h[:id].blank? ? Address.all_for(self.organization_uid).find(h[:id].to_i) : Address.new_for_organization(self.organization_uid)
    self.address.attributes = h
  end
  
  protected
    def save_address
      address.save if address
    end
end
