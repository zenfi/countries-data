require 'yaml'
require_relative './country'

module CountriesData
  class Collection
    DATA = YAML.load(File.read(File.join(__dir__, 'data.yml')), symbolize_names: true).freeze

    COUNTRIES = DATA[:countries].map { |c| Country.new(c) }.freeze

    IDS_MAP = COUNTRIES.each_with_index.reduce({}) do |prev, (country, index)|
      prev[country.id] = index
      prev
    end

    PHONE_CODES_MAP = COUNTRIES.each_with_index.reduce({}) do |prev, (country, index)|
      next prev if country.phone_code.nil?
      prev[country.phone_code] = [] if prev[country.phone_code].nil?
      prev[country.phone_code].push(index)
      prev
    end

    def self.all
      COUNTRIES
    end

    def self.find_by_id(id)
      index = IDS_MAP[id.to_s]
      return COUNTRIES[index] unless index.nil?
    end

    def self.find_by_phone_code(phone_code)
      indexes = PHONE_CODES_MAP[phone_code] || []
      return indexes.map { |index| COUNTRIES[index] }
    end
  end
end
