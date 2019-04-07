require 'hanami/validations'

module UserPredicates
  include Hanami::Validations::Predicates

  self.messages_path = 'config/errors.yml'

  predicate(:email?) do |input|
    !/.+@.+/.match(input).nil?
  end
end
