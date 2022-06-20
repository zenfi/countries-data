module CountriesData
  class Country
    attr_reader :id
    attr_reader :emoji
    attr_reader :names
    attr_reader :phone_code

    PHONE_MIN_LENGTH = 5
    PHONE_MAX_LENGTH = 14

    def initialize(data)
      @id = data[:id]
      @emoji = data[:emoji]
      @names = data[:names]
      @phone_code = data[:phone_code]
      @phone_min_length = data[:phone_min_length]
      @phone_max_length = data[:phone_max_length]
    end

    def name(locale)
      names[locale.to_sym]
    end

    def phone_min_length
      @phone_min_length || PHONE_MIN_LENGTH
    end

    def phone_max_length
      @phone_max_length || PHONE_MAX_LENGTH
    end
  end
end
