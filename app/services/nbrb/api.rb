module Nbrb
  module Api
    extend Currencies

    WSDL = 'http://www.nbrb.by/Services/ExRates.asmx?WSDL'.freeze

    def self.call(operation, params = {})
      client.call(operation, params)
    rescue Savon::UnknownOperationError
      raise Nbrb::Api::OperationNotFound, "NBRB operation #{operation} was not found"
    end

    def self.client
      @client ||= Savon.client(wsdl: WSDL, log: false)
    end
  end
end
