@smoke
@items
Feature:
  As a guest of pivotal tracker
  I want to test the SMOKE validations for items Endpoints
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

  @smoke @delete_items
  Scenario: Get Items
    When I send a GET request to my/items
    Then I expect status code 200

  @smoke
  Scenario: PUT Items
    Given I send a POST request to projects
    """
    {
      "name" : "items-project02"
    }
    """
    And I save the response as project_response
    Then I expect status code 200
    When I send the PUT request to my/items/<item_id>
     """
     {
        "project_ids": [items-project02]
     }
     """
    Then I expect status code 200

  @smoke @delete_items
  Scenario: Delete items
    When I send a DELETE request to my/items/<item_id>
    Then I expect status code 204

