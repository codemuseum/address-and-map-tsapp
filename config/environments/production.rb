# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Enable threaded mode
# config.threadsafe!

# Use a different logger for distributed setups
# config.logger = SyslogLogger.new

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true

# Use a different cache store in production
# config.cache_store = :mem_cache_store

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host                  = "http://assets.example.com"
# config.action_controller.asset_host                  = "http://address-and-map.heroku.com"
config.action_controller.asset_host                  = "209.20.86.103"

# Disable delivery errors, bad email addresses will be ignored
# config.action_mailer.raise_delivery_errors = false

# CONFIG_GMAPS_KEY = 'ABQIAAAAM1Xg3KS4pBFHn63v6AkVtBR8bIw_VtH5wPYybJ17-EVbyyZ8WhQrTCi_biWB3ktBLeNgq1l2feE-mw'
# CONFIG_GMAPS_DOMAIN = 'address-and-map.heroku.com'

CONFIG_GMAPS_KEY = 'ABQIAAAAM1Xg3KS4pBFHn63v6AkVtBQL1Zo14raxyPEZGZ2LmjYD5hqRDhQZd-D3Uyg9g_WSILpqk81x7Jvzww'
CONFIG_GMAPS_DOMAIN = '209.20.86.103'

# FIXME when http://code.google.com/p/phusion-passenger/issues/detail?id=169 is fixed
config.action_controller.relative_url_root = "/address-and-map"
