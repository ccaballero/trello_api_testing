@crud
Feature: CRUD lists

  @create @acceptance
  Scenario: Create list
    Given I have an existing board
    When I send a POST request to /lists with name myName
    Then I get a response with  HTTP status code 200
      And with valid body
    