require 'rails_helper'

RSpec.describe "File Upload" do

  it "parses the file and returns customers correctly" do
    file_path = Rails.root.join('spec/fixtures/files/customers.txt')
    file =  File.open(file_path)
    file_processor = FileProcessor.new(file)
    customers = file_processor.parse_customers
    expect(customers.length).to eq(200)
    expect(customers.first.user_id).to eq(1)
    expect(customers.first.name).to eq("Vivaan Sharma")
    expect(customers.last.user_id).to eq(200)
    expect(customers.last.name).to eq("Aarav Kapoor")
  end
  
end
