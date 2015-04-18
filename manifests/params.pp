# Class: puppet_hipchat::params
#
# Parameterize for Puppet platform.
#
class puppet_hipchat::params {

  $package_name   = 'hipchat'
  $install_hc_gem = true
  $puppetboard    = false
  $dashboard      = false

  if str2bool($::is_pe) {
    $puppetconf_path = '/etc/puppetlabs/puppet'
    $owner           = 'pe-puppet'
    $group           = 'pe-puppet'
    
    case $::puppetversion {
      /Puppet Enterprise 3.[0-6]/: {
        $provider = 'pe_gem'
      }

      /Puppet Enterprise [1-2]/: {
        fail("Wow, that's an old PE. Sorry, not it's supported")
      }

      default: {
        $provider = 'pe_puppetserver_gem'
      }
    }
  } else {
    $puppetconf_path = '/etc/puppet'
    $provider        = 'gem'
    $owner           = 'puppet'
    $group           = 'puppet'
  }
}
