# DELETE /organizations
# authos: Carlos E. Caballero B.

@organizations @crud
Feature: Organizations management (DELETE)
Organizations, or as they are referred to in Trello, "Teams", represent
collections of members and boards.

Parameters definition:

- id: mandatory parameter

    @acceptance @delete
    Scenario: Delete of a pre-established organization
       Given I have an existing organization with parameters
            |   PARAMETER | VALUE               |
            |        name | {organization}      |
            | displayName | example             |
            |        desc | description example |
            |     website | http://example.io   |
        When I send a DELETE request to /organizations/{organization_id}
        Then I get a response status code 200
         And I get a response header content-type application/json
         And I get a response text
        """
        {}
        """

    @negative @delete
    Scenario: Delete information from a nonexistent resource
        When I send a DELETE request to /organization/nonexistent
        Then I get a response status code 404
         And I get a response header content-type text/plain
         And I get a response text
        """
        model not found
        """

