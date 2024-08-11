# Instead of FactoryBot.build :article, we gonna use :article

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
