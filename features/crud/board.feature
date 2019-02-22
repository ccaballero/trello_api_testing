@crud
Feature: CRUD Board
  Testing a REST API
  the users should be able to submit GET,  POST, PUT and  DELETE requests to Trello  web service


  @get @acceptance
  Scenario: Check if user is able to submit GET API request
    Given I want to execute service GET
    When I submit the GET request to /boards/{id}
    Then I get a response with  HTTP status code 200
    And with valid body


  @create @acceptance
  Scenario: Check if user is able to submit POST API request

    Given I want to execute service POST
    When I submit the POST request to /boards/
    Then I get a response with  HTTP status code 200
    And with valid body


  @update @acceptance
  Scenario: Check if user is able to submit  PUT request

    Given I want to execute service PUT
    When I send a PUT request to /boards/{id}
    Then I get a response with  HTTP status code 200
    And with valid body

  @delete @acceptance
  Scenario: Check if user is able to submit GET API request

    Given I want to execute service <serviceName>
    When I send a DELETE request to /boards/{id}
    Then I get a response with  HTTP status code 200
    And with valid body
