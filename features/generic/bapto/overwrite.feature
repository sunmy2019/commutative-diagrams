# features/bapto/overwrite.feature
Feature: bapto's overwrite key

  Background: testing bapto in a generic context
    Given I'm using any TeX flavour
    And I use "tikz"
    And I use the "kodi.katharizo" TikZ library
    And I use the "kodi.bapto" TikZ library

  Scenario: using default behaviour (overwrite=false)
    Given I code \tikz\node[self naming, name=foo, node contents=bar];
    And I expect a node labeled "foo" to exist
    And I expect a node labeled "bar" to not exist
    Then compilation succeeds

  Scenario Outline: setting overwriting behaviour
    Given I code \pgfqkeys{/bapto}{overwrite=<overwrite>}
    And I code \tikz\node[self naming, name=foo, node contents=bar];
    And I expect a node labeled "foo" to <name label>
    And I expect a node labeled "bar" to <self label>
    Then compilation succeeds

  Examples:
    | overwrite | name label | self label |
    | false     | exist      | not exist  |
    | true      | not exist  | exist      |
    | alias     | exist      | exist      |