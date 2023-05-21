@Regression
Feature: Get Account API

  #Scenario 9:
  #Endpoint = /api/accounts/get-account
  #For primaryPersonId one of ypur accounts created prior to this test
  #Make sure email address is coorect
  Background: Setup test URL
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Get account
    And path "/api/token"
    And request {"username":"supervisor","password":"tek_supervisor"}
    When method post
    Then status 200
    And print response
    * def generatedToken = response.token
    Given path "/api/accounts/get-account"
    And header Authorization = "Bearer "+ generatedToken
    And param primaryPersonId = 5345
    When method get
    Then status 200
    And print response
    And assert response.primaryPerson.email == "test78@gmail.com"
    And assert response.primaryPerson.id == 5345
