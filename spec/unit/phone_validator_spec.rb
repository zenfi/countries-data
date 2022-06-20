require 'spec_helper'
require 'countries_data/phone_validator'

RSpec.describe CountriesData::PhoneValidator, type: :module do
  let(:validator) { described_class.new(phone) }

  describe '#valid?' do
    let(:format?) { true }
    let(:length?) { true }
    let(:code?) { true }
    let(:phone) { {} }

    before do
      allow(validator).to receive(:valid_format?).and_return(format?)
      allow(validator).to receive(:valid_length?).and_return(length?)
      allow(validator).to receive(:valid_code?).and_return(code?)
    end

    subject { validator.valid? }

    context 'when format is not valid' do
      let(:format?) { false }
      it { should eq(false) }
    end

    context 'when format is not valid' do
      let(:length?) { false }
      it { should eq(false) }
    end

    context 'when format is not valid' do
      let(:code?) { false }
      it { should eq(false) }
    end

    context 'when all is valid' do
      it { should eq(true) }
    end
  end

  describe '#valid_format?' do
    subject { validator.valid_format? }

    context 'when does not have international code' do
      let(:phone) { { code: nil, number: '3310146848' } }
      it { should eq(false) }
    end

    context 'when does not have a phone number' do
      let(:phone) { { code: '52', number: nil } }
      it { should eq(false) }
    end

    context 'when has a non-digit character' do
      let(:phone) { { code: '52', number: 'E310146848' } }
      it { should eq(false) }
    end

    context 'when has a valid format' do
      let(:phone) { { code: '52', number: '3310146848' } }
      it { should eq(true) }
    end
  end

  describe '#valid_length?' do
    subject { validator.valid_length? }

    context 'when the phone is shorter in the country (valid: 10 for Mexico)' do
      let(:phone) { { code: '52', number: '331014684' } }
      it { should eq(false) }
    end

    context 'when the phone is larger in the country (valid: 10 for Mexico)' do
      let(:phone) { { code: '52', number: '33101468488' } }
      it { should eq(false) }
    end

    context 'when has a valid length' do
      let(:phone) { { code: '52', number: '3310146848' } }
      it { should eq(true) }
    end
  end

  describe '#valid_code?' do
    subject { validator.valid_code? }

    context 'when does not have international code' do
      let(:phone) { { code: nil, number: '3310146848' } }
      it { should eq(false) }
    end

    context 'when the internation code does not exist' do
      let(:phone) { { code: '666', number: '3310146848' } }
      it { should eq(false) }
    end

    context 'when has a valid code' do
      let(:phone) { { code: '52', number: '3310146848' } }
      it { should eq(true) }
    end
  end

  describe '#min_length' do
    let(:phone) { { code: '1', number: '3310146848' } }

    subject { validator.min_length }

    it 'returns the minimum expected length of a number, depending on the country it belongs to' do
      expect(subject).to eq(5)
    end
  end

  describe '#max_length' do
    let(:phone) { { code: '1', number: '3310146848' } }

    subject { validator.max_length }

    it 'returns the maximum expected length of a number, depending on the country it belongs to' do
      expect(subject).to eq(14)
    end
  end
end
