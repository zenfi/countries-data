require_relative 'lib/countries_data/version'

Gem::Specification.new do |spec|
  spec.name     = 'countries_data'
  spec.version  = CountriesData::VERSION
  spec.licenses = ['MIT']
  spec.authors  = ['Manuel de la Torre']
  spec.summary  = 'Contains useful information about all of the countries'
  spec.homepage = 'https://github.com/zenfi/countries-data'
  spec.required_ruby_version = '>= 2.6'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata = {
    'rubygems_mfa_required' => 'true',
    'homepage_uri' => spec.homepage,
    'source_code_uri' => 'https://github.com/zenfi/countries-data',
    'changelog_uri' => 'https://github.com/zenfi/countries-data/CHANGELOG.md'
  }

  spec.files = Dir['lib/**/*']
end
