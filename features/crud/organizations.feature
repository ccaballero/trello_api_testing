# /organizations

@crud
Feature: Organizations management
Organizations, or as they are referred to in Trello, "Teams", represent
collections of members and boards.

    @acceptance @create
    Scenario: Create a new team
        When I send a POST request to /organizations
         And I set the query param displayName as "example"
         And I set the query param desc as "description example"
         And I set the query param name as "example"
         And I set the query param website as "http://example.io"
        Then I get a response status code 200
         And I get a response json


