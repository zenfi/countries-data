require_relative './collection'

module CountriesData
  class PhoneValidator
    attr_reader :code
    attr_reader :number

    def initialize(code: nil, number: nil)
      @code = code
      @number = number
    end

    PHONE_REGEXP = Regexp.new("^\\d+$")

    def valid?
      valid_format? && valid_code? && valid_length?
    end

    def valid_format?
      PHONE_REGEXP.match?(code) && PHONE_REGEXP.match?(number)
    end

    def valid_code?
      !countries.empty?
    end

    def valid_length?
      return false unless number&.length
      length = number.length
      length >= min_length && length <= max_length
    end

    def min_length
      countries
        .map { |country| country.phone_min_length }
        .compact
        .min || 0
    end

    def max_length
      countries
        .map { |country| country.phone_max_length }
        .compact
        .max || Float::INFINITY
    end

    private

    def countries
      @countries = Collection.find_by_phone_code(code)
    end
  end
end
