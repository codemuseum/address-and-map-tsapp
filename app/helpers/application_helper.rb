# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def chop_protocol(url)
    return nil unless url
    parts = url.split(/:\/\//)
    result = nil
    if parts.size > 1
      result = parts[1] 
    else
      result = parts[0]
    end

    result.gsub(/\/$/, '')
  end
  
  def obfuscated_mailto(email, title, class_name = nil)
    link_to title, "mailto:#{email}"
  end
  
  # Without the mailto:
  def obfuscated_email(email)
    email
  end

  def google_maps_url(obj)
    "http://#{CONFIG_GMAPS_DOMAIN}" + 
      map_path(:i => obj.id, 
        :a => obj.location_s(false), 
        :al => location_directions_url(obj, (obj.name ? obj.name : '')))
  end
  
  
  def location_directions_url(obj, *titles)
    if obj.mappable?
  	  escaped_loc = CGI::escape obj.location_s
  	
    	unless titles.empty?
    	  escaped_loc << CGI::escape(' (' + titles.join(" - ") + ')')
    	end
    	
    	"http://maps.google.com/maps?q=#{escaped_loc}" 
  	else 
  	  nil
  	end
  end
  
  
end
