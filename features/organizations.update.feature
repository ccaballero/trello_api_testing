# /organizations
# author: Carlos E. Caballero B.

@organizations @crud
Feature: Organizations management (UPDATE)
Organizations, or as they are referred to in Trello, "Teams", represent
collections of members and boards.

Parameters definition:

- id: mandatory parameter
- name: A new name for the organization. At least 3 lowercase letters,
        underscores, and numbers. Must be unique
- displayName: A new displayName for the organization. Must be at least 1
        character long and not begin or end with a space.
- desc: A new description for the organization
- website: A URL starting with http://, https://, or null
- prefs/associatedDomain: The Google Apps domain to link this org to.
- prefs/externalMembersDisabled: Whether non-team members can be added to
        boards inside the team
- prefs/googleAppsVersion: 1 or 2
- prefs/boardVisibilityRestrict/org: Who on the team can make team visible
        boards. One of admin, none, org
- prefs/boardVisibilityRestrict/private: Who can make private boards. One of:
        admin, none, org
- prefs/boardVisibilityRestrict/public: Who on the team can make public boards.
        One of: admin, none, org
- prefs/orgInviteRestrict: An email address with optional wildcard characters.
        (E.g. subdomain.*.trello.com)
- prefs/permissionLevel: Whether the team page is publicly visible. One of:
        private, public

This method lets you update one or more properties of the organization in a
    single request.

It is also possible to update a single property:

    PUT /1/organizations/{id}/{property}?value={new value}

So for example, to update just the displayName for an org you could also do:

    PUT /1/organizations/{id}/displayName?value=Awesome%20Team

    @acceptance @update
    Scenario: Update information of a pre-established organization
       Given I have an existing organization with parameters
            |        name | example             |
            | displayName | example             |
            |        desc | description example |
            |     website | http://example.io   |
        When I set the query parameters:
            |        name | new_example             |
            | displayName | new_example             |
            |        desc | description new example |
            |     website | http://new.example.io   |
         And I send a PUT request to /organizations/{id}
        Then I get a response status code 200
         And I get a response header content-type application/json
         And I get a response json based on json schema
        """
        {
            "type":"object",
            "properties":{
                "id":          {"type":"string"},
                "name":        {"type":"string"},
                "displayName": {"type":"string"},
                "desc":        {"type":"string"},
                "url":         {"type":"string"},
                "website":     {"type":"string"}
            },
            "required":["id","name","displayName","desc","url","website"]
        }
        """
         And I get a return values:
            |        name | new_example             |
            | displayName | new_example             |
            |        desc | description new example |
            |     website | http://new.example.io   |

    @negative @update
    Scenario: Update information of an organization with param name with 1
        characters
       Given I have an existing organization with parameters
            |        name | example             |
            | displayName | example             |
            |        desc | description example |
            |     website | http://example.io   |
        When I set the query parameters:
            |        name | e                       |
            | displayName | new_example             |
            |        desc | description new example |
            |     website | http://new.example.io   |
         And I send a PUT request to /organizations/{id}
        Then I get a response status code 200
         And I get a response header content-type application/json
         And I get a response text
        """
        Display Name must be at least 1 character
        """

