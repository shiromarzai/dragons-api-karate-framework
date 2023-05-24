@Regression
Feature: Get All Accounts

  Background: Setup Test URL
    * def generatedToken = callonce read('GenerateTokenReal.feature')
    * def genToken = generatedToken.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Test Get All Accounts
    Given path "/api/accounts/get-all-accounts"
    And header Authorization = "Bearer " + genToken
    When method get
    Then status 200
