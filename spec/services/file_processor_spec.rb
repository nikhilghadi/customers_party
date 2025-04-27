require 'rails_helper'

describe "File Upload" do

  it "uploads without file" do
    file_path = nil
    mime_type = '' 
    file =  Rack::Test::UploadedFile.new(file_path, mime_type)
    post customers_upload_path, params: { file: file }
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it "uploads wrong format file" do
    file_path = Rails.root.join('spec/fixtures/files/dummy.pdf')
    mime_type = 'application/pdf' 
    file =  Rack::Test::UploadedFile.new(file_path, mime_type)
    post customers_upload_path, params: { file: file }
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it "uploads large file" do
    file_path = Rails.root.join('spec/fixtures/files/large_customers.txt')
    mime_type = 'text/plain' 
    file =  Rack::Test::UploadedFile.new(file_path, mime_type)
    post customers_upload_path, params: { file: file }
    expect(response).to have_http_status(:unprocessable_entity)
  end


  it "uploads a file" do
    file_path = Rails.root.join('spec/fixtures/files/customers.txt')
    mime_type = 'text/plain' 
    file =  Rack::Test::UploadedFile.new(file_path, mime_type)
    post customers_upload_path, params: { file: file }
    expect(response).to have_http_status(:success)
    doc = Nokogiri::HTML(response.body)
    customers = doc.css("turbo-frame#customers_table tr td").map(&:text)
    expect(customers).to include("25")
  end
  
end
