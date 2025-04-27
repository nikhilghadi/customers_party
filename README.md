# README

This a a RoR application to upload text file containing customers data in json format
and return customers list within 100 KM from from Mumbai Office. Return the sorted customer information by user_id

Prerequisite
  Docker (for easy setup)

1) Setup Instruction
  ```
    gh repo clone nikhilghadi/customers_party
    cd customers_party
  ```
2) Build the Docker image

If you're using Docker, you'll first need to build the Docker image. Run the following command to build the image from the Dockerfile:
  ```
  docker build -t customers_party .
  ```


3) Run the application with Docker Compose
  You can use Docker Compose to set up the application in one command:
```
  docker-compose up --build
```

4) Run the Rails server

  After the application starts, it should be available at http://localhost:3000. You can check the application by navigating to that URL in your browser.

5) Setup Without Docker
  After cloning repo
  run
  ```
    bundle install
    rails s
  ```

7) Running Tests
  To run the tests within the Docker container, follow these steps:

  Run tests with Docker Compose

  You can run your tests by executing the following command:

  ```
    docker-compose run app rspec
  ```

  This will execute all the RSpec tests inside the Docker container, ensuring that your tests are run in the same environment as the production application.

8) Running testcases without docker
     ```
    bundle exec rspec
    this command will execute all testcases
    ```
9) API Documentation
    You can find the documentation for the API at /http://localhost:3000/api-docs. This includes the available endpoints, request formats, and expected responses. If you want to test the API or review the     documentation, you can visit the following URL after starting the server:

  API docs: http://localhost:3000/api-docs

  API to upload a customers.txt file, filter customers within a specified distance (default 100km) of Mumbai office, and return sorted list by user_id.

  POST /customers/upload
  Upload Customers File

  Upload a .txt file containing customer JSON lines. Filters customers based on distance from Mumbai office.

  Parameters
    file *
      Text file containing customer records in JSON lines format.

    distance
      integer
      Distance in kilometers (optional, default is 100km).

  Responses
    200	
      List of customers within the distance, sorted by user_id ascending.
    402
      Three validations are added
        File is mandatory
        File size must me less than 3MB
        Only Text Files are accepted

