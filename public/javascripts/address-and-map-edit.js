var AddressAndMapEdit = {
  init: function() {
    $$('.app-address-and-map').each(function(el) {     
      var savedForms = el.select('.saved-addresses')[0].remove();
      
      el.select('.selector select').each(function(selector) { selector.observe('change', function(ev) {
        var selectedId = selector.options[selector.selectedIndex].value;
        var selectedFields = savedForms.select('.hidden-fields.address-fields-' + selectedId)[0];
        el.select('div.fields')[0].update(selectedFields.innerHTML);
        if (selector.options[selector.selectedIndex].innerHTML == '-None Yet-') { el.select('div.address-details')[0].addClassName('hidden'); }
        else { el.select('div.address-details')[0].removeClassName('hidden'); }
        el.select('input')[0].focus();
        AddressAndMapEdit.updateMap(el);
      }); });
    
      el.select('.directions a').each(function(a) {
        a.observe('click', function() { AddressAndMapEdit.updateMap(el); });
      });
    });
  },
  
  updateMap: function(map) {
    var name = map.select('h2 input')[0];
    var street = map.select('.street-line1 input')[0];
    var city = map.select('.city input')[0];
    var state = map.select('.state input')[0];
    var zip = map.select('.zip input')[0];
    var country = map.select('.country select')[0];
    var location = street.value + ", " + city.value + " " + state.value + (country.value ? ", " + country.value : "");
    
    var iframeObj = map.select('iframe')[0];
    var iframe = window.frames[iframeObj.name];
    var prevUrl = iframeObj.src;
    var host = prevUrl.substring(0, prevUrl.indexOf('?'));
    iframe.location.replace(
      host + 
      "?a="  + escape(location) + 
      "&af=" + escape(location + (name.value ? name.value : ''))
    );
  }
}
AddressAndMapEdit.init();