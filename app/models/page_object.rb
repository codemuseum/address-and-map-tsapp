class PageObject < ActiveRecord::Base
  include ThriveSmartObjectMethods
  self.caching_default = :any_page_update #[in :forever, :page_update, :any_page_update, 'data_update[datetimes]', :never, 'interval[5]']

  belongs_to :address
  attr_protected :address_id
  
  after_update :save_address
  
  
  def validate
    if address && !address.valid?
      errors.add(:address, " has an error that must be corrected.")
    end
  end
  
  def all_addresses_for_form
    all_addresses.map { |a| [a.name, a.id] }
  end
  
  
  def all_addresses
    Address.all_for(self.organization_uid)
  end
  
  # Find the right address, allowing for the possibility there might be a carbon copy duplicate that doesn't have an ID (data migration)
  def assigned_address=(h)
    if h[:id].blank?
      self.address = Address.all_for(self.organization_uid).find(h[:id].to_i)
    elsif (dup = Address.duplicate_for(self.organization_uid, h).first)
      self.address = dup
    else
      self.address = Address.new_for_organization(self.organization_uid)
    end
    self.address = !h[:id].blank? ?  : 
    self.address.attributes = h
  end
  
  protected
    def save_address
      address.save if address
    end
end
