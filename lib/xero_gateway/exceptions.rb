module XeroGateway
  class NoGatewayError < StandardError; end
  class AccountsListNotLoadedError < StandardError; end
  class InvalidLineItemError < StandardError; end

  class ApiException < StandardError
    attr_reader :request_xml, :response_xml

    def initialize(type, message, request_xml, response_xml)
      @type         = type
      @message      = message
      @request_xml  = request_xml
      @response_xml = response_xml
      super(message)
    end

    def full_message
      "#{@type}: #{@message} \n Generated by the following XML: \n #{@response_xml}"
    end
  end

  class UnparseableResponse < StandardError

    def initialize(root_element_name)
      @root_element_name = root_element_name
    end

    def message
      "A root element of #{@root_element_name} was returned, and we don't understand that!"
    end

  end

  class ObjectNotFound < StandardError

    def initialize(api_endpoint)
      @api_endpoint = api_endpoint
    end

    def message
      "Couldn't find object for API Endpoint #{@api_endpoint}"
    end

  end

  class InvoiceNotFoundError < StandardError; end
  class BankTransactionNotFoundError < StandardError; end
  class CreditNoteNotFoundError < StandardError; end
  class ManualJournalNotFoundError < StandardError; end
  class EmployeeNotFoundError < StandardError;end
  class PayslipNotFoundError < StandardError;end
end
