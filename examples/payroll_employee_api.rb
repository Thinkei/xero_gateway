require 'rubygems'
require 'pp'
require 'yaml'

require File.dirname(__FILE__) + '/../lib/xero_gateway.rb'

XERO_KEYS = YAML.load_file(File.dirname(__FILE__) + '/xero_keys.yml')

gateway = XeroGateway::Gateway.new(XERO_KEYS["xero_consumer_key"], XERO_KEYS["xero_consumer_secret"])

# authorize in browser specific to payroll-API
%x(open #{gateway.request_token.authorize_url}"&scope=payroll.employees")

puts "Enter the verification code from Xero?"
oauth_verifier = gets.chomp

gateway.authorize_from_request(gateway.request_token.token, gateway.request_token.secret, :oauth_verifier => oauth_verifier)

# Example of employee creation

# Push employee details via Payroll API
pp "**** pushing payroll employees with Firstname, Lastname, and Email"
payroll_employee = gateway.build_payroll_employee({first_name: "EFirstName",
                                           email: "myemployee@xero.com",
                                           last_name: "ELastName"})
pp "**** saving employee"
gateway.create_payroll_employee(payroll_employee)

pp "**** GET new employee"
new_payroll_employee = gateway.get_payroll_employee_by_id(payroll_employee.employee_id)
pp new_payroll_employee