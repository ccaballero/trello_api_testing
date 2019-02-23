@crud
@items
Feature:
  As a guest of pivotal tracker
  I want to test the CRUD validations for items Endpoints
  In order to assure the basic functionality working

  Background: Create a items
    When I send a POST request to projects
    """
    {
      "name" : "items-project01"
    }
    """
    And I save the response as project_response
    When I send the POST request to my/items
    """
    {
      "name" : "items-auto",
      "project_ids":[items-project01]
    }
    """
    And I save the response as items_response
    Then I expect status code 200

  @delete_items
  Scenario: The items created with a specific name and contains a specific project
    When I send a GET request to my/items
    Then the items created should contain the following data
    """
    {
      "name" : "items-auto"
    }
    """
    And the items should contain the project created