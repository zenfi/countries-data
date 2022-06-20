require 'spec_helper'
require 'countries_data/country'

RSpec.describe CountriesData::Country, type: :module do
  let(:data_mx) do
    {
      id: 'MX',
      emoji: '🇲🇽',
      names: {
        es: 'México',
        en: 'Mexico'
      },
      phone_code: '52',
      phone_min_length: 10,
      phone_max_length: 11
    }
  end

  describe '#name' do
    let(:country) { described_class.new(data_mx) }

    context 'when requesting the name in a valid locale' do
      it 'returns the Spanish name for locale = es' do
        expect(country.name(:es)).to eq('México')
      end

      it 'returns the English name for locale = en' do
        expect(country.name(:en)).to eq('Mexico')
      end
    end

    context 'when requesting the name with an invalid locale' do
      it 'returns nil' do
        expect(country.name(:it)).to be_nil
      end
    end
  end

  describe '#phone_min_length' do
    context 'when the country has a value' do
      let(:country) { described_class.new(data_mx) }

      it 'returns its value' do
        expect(country.phone_min_length).to eq(data_mx[:phone_min_length])
      end
    end

    context 'when the country has not a value' do
      let(:country) { described_class.new(data_mx.merge(phone_min_length: nil)) }

      it 'returns its value' do
        expect(country.phone_min_length).to eq(described_class::PHONE_MIN_LENGTH)
      end
    end
  end

  describe '#phone_max_length' do
    context 'when the country has a value' do
      let(:country) { described_class.new(data_mx) }

      it 'returns its value' do
        expect(country.phone_max_length).to eq(data_mx[:phone_max_length])
      end
    end

    context 'when the country has not a value' do
      let(:country) { described_class.new(data_mx.merge(phone_max_length: nil)) }

      it 'returns its value' do
        expect(country.phone_max_length).to eq(described_class::PHONE_MAX_LENGTH)
      end
    end
  end
end
