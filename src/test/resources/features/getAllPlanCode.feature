@Regression
Feature: Get All Plan Code Test

  Background: Setup Test URL
    * def token = callonce read('GenerateTokenReal.feature')
    * def token = token.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Get All Test
    Given path "/api/plans/get-all-plan-code"
    And header Authorization = "Bearer " + token
    When method get
    Then status 200
    And print response
