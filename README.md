# Countries data

![Tests](https://github.com/zenfi/api/workflows/Tests/badge.svg)
![Ruby](https://img.shields.io/badge/ruby-%3E%3D%202.6.9-blue)
![License](https://img.shields.io/github/license/zenfi/countries-data?color=blue)

Ruby Gem with useful information about countries.

* Name (`English` and `Spanish` available).
* Emoji
* Phone validation

## Install

Just add the gem to your project:

```sh
gem install countries_data

# Or using bundler
bundle add countries_data
```

## Usage

This project exposes the following models:

### CountriesData::Collection

The purpose of this model is to list all the countries or find some depending on criteria.

#### `.all`

This method returns all existing countries.

**Params**

This method accepts no parameters.

**Example:**

```rb
countries = CountriesData::Collection.all
# [#<CountriesData::Country:0x000000014029adb0 @id="AD", @emoji="🇦🇩", @names={:es=>"Andorra", :en=>"Andorra"}...
```

#### `.find_by_id`

Returns a country by its id.

**Params**

| Parameter | Type | Descriptipn |
|-----------|------|-------------|
|`id`|`String`|**Required**. The ID of the country to be fetched.|

**Example:**

```rb
country = CountriesData::Collection.find_by_id('CA')
# #<CountriesData::Country:0x000000014029a7e8 @id="CA"...
```

#### `.find_by_phone_code`

Returns a list of the countries that use an international phone code.

**Params**

| Parameter | Type | Descriptipn |
|-----------|------|-------------|
|`phone_code`|`String`|**Required**. The phone code used to find matches.|

**Example:**

```rb
countries = CountriesData::Collection.find_by_phone_code('1')
# [#<CountriesData::Country:0x000000014029a7e8 @id="US"...
```

### CountriesData::Country

This method represents a single country and its related data.

A country instance exposes the following attributes:

| Attribute | Type | Descriptipn |
|-----------|------|-------------|
|`id`|`String`|The ISO8601 code of the country.|
|`emoji`|`String`|The related emoji.|
|`names`|`Hash`|The dictionary of names.|
|`phone_code`|`String`|The international phone number.|
|`phone_min_length`|`Integer`|The minimum number of digits for the phone numbers (excluding the international code).|
|`phone_max_length`|`Integer`|The maximum number of digits for the phone numbers (excluding the international code).|

#### `#name`

Returns the country name in a specific locale. Currently only `en` and `es` are supported.

**Params**

| Parameter | Type | Descriptipn |
|-----------|------|-------------|
|`phone_code`|`String`|**Required**. The phone code used to find matches.|

**Example:**

```rb
country = CountriesData::Collection.find_by_id('MX')
country.name(:es) # Returns "México"
```

### CountriesData::PhoneValidator

The model exposes methods to validate a international phone number.

#### `.new`

Builds a new phone validator instance.

**Params**

| Parameter | Type | Descriptipn |
|-----------|------|-------------|
|`code`|`String`|**Required**. The international code of the phone.|
|`number`|`String`|**Required**. The local number parte of the phone.|

**Example:**

```rb
validator = CountriesData::PhoneValidator.new(code: '1', number: '3103636000')
```

A phone validator instance exposes the following attributes:

| Attribute | Type | Descriptipn |
|-----------|------|-------------|
|`valid?`|`Boolean`|Indicates if the phone meets all of the criteria to be valid (including code and number).|
|`valid_format?`|`Boolean`|Indicates if both the code and the number have the correct format.|
|`valid_code?`|`Boolean`|Indicates if the code is a valid international phone code.|
|`valid_length?`|`Boolean`|Indicates if the number meets the length criteria.|
|`min_length`|`Integer`|The minimum length that is valid depending on the international code.|
|`max_length`|`Integer`|The maximum length that is valid depending on the international code.|

## License

MIT
