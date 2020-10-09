require 'webmock/rspec'
require 'savon/mock/spec_helper'

module NbrbHelpers
  RSpec.configure do |c|
    c.before :all do
      savon.mock!
    end
    c.after :all do
      savon.unmock!
    end

    c.before :each do
      WebMock.stub_request(:get, Nbrb::Api::WSDL)
             .to_return(status: 200, headers: {}, body: fixture('nbrb/wsdl.xml'))
    end
  end

  WebMock.disable_net_connect!(allow_localhost: true)
end
