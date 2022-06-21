require 'yaml'
require_relative './country'

module CountriesData
  class Collection
    DATA = YAML.safe_load(File.read(File.join(__dir__, 'data.yml')), symbolize_names: true).freeze

    COUNTRIES = DATA[:countries].map { |c| Country.new(c) }.freeze

    IDS_MAP = COUNTRIES.each_with_index.each_with_object({}) do |(country, index), prev|
      prev[country.id] = index
    end

    PHONE_CODES_MAP = COUNTRIES.each_with_index.each_with_object({}) do |(country, index), prev|
      next prev if country.phone_code.nil?

      prev[country.phone_code] = [] if prev[country.phone_code].nil?
      prev[country.phone_code].push(index)
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
      indexes.map { |index| COUNTRIES[index] }
    end
  end
end
