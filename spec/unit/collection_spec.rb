require 'spec_helper'
require 'countries_data/collection'

RSpec.describe CountriesData::Collection, type: :module do
  let(:all) { described_class.all }

  describe '.all' do
    def expect_country(country)
      expect(country.id).not_to be_nil
      expect(country.emoji).not_to be_nil
    end

    it 'returns a list of countries' do
      data_file = File.join(File.dirname(__dir__), '../lib/countries_data/data.yml')
      data = YAML.load_file(data_file)
      expect(all.size).to be_positive
      expect(all.size).to eq(data['countries'].size)
      all.each { |country| expect_country(country) }
    end
  end

  describe '.find_by_id' do
    it 'returns the correct country for each different string id' do
      all.each do |country|
        result = described_class.find_by_id(country.id.to_s)
        expect(result.id).to eq(country.id)
      end
    end

    it 'returns the correct country for each different symbol id' do
      all.each do |country|
        result = described_class.find_by_id(country.id.to_sym)
        expect(result.id).to eq(country.id)
      end
    end

    it 'returns nil for an unexistent id' do
      result = described_class.find_by_id('NON_EXISTENT')
      expect(result).to be_nil
    end
  end

  describe '.find_by_phone_code' do
    it 'returns the correct countries for each different phone code' do
      all.each do |country|
        next if country.phone_code.nil?

        results = described_class.find_by_phone_code(country.phone_code)
        ids = results.map { |element| element.id }
        expect(ids).to include(country.id)
      end
    end

    it 'returns empty array for an unexistent phone code' do
      result = described_class.find_by_phone_code('NON_EXISTENT')
      expect(result).to eq([])
    end
  end
end
