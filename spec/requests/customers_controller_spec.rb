require 'rails_helper'

RSpec.describe "Customers API", type: :request do


  it "uploads without file" do
    post "/customers/upload", params: {distance: 100 },   headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
    expect(response).to have_http_status(:unprocessable_entity)
    expect(response.body).to include("Please upload a file")
  end

  it "uploads wrong format file" do
    file_path = Rails.root.join('spec/fixtures/files/dummy.pdf')
    mime_type = 'application/pdf' 
    file =  Rack::Test::UploadedFile.new(file_path, mime_type)
    post customers_upload_path, params: { file: file }, headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
    expect(response).to have_http_status(:unprocessable_entity)
    expect(response.body).to include("Only .txt files are allowed.")

  end

  
  it "uploads large file" do
    file_path = Rails.root.join('spec/fixtures/files/large_customers.txt')
    mime_type = 'text/plain' 
    file =  Rack::Test::UploadedFile.new(file_path, mime_type)
    post customers_upload_path, params: { file: file }, headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
    expect(response).to have_http_status(:unprocessable_entity)
    expect(response.body).to include("File size exceeds the maximum limit (3MB).")

  end

  it "uploads proper file get 2 employee in repsonse" do
    file_path = Rails.root.join('spec/fixtures/files/customers.txt')
    mime_type = 'text/plain' 
    file =  Rack::Test::UploadedFile.new(file_path, mime_type)
    post customers_upload_path, params: { file: file }, headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Pratik")
    expect(response.body).to include("Manish")
  end
end
