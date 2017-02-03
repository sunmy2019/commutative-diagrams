# features/koinos/kDTrimLeadingSpace_macro.feature
Feature: kDTrimLeadingSpace trims leading spaces from a token list

  Background: testing koinos in a generic context
    Given I'm using any TeX flavour
    And I use "tikz"
    And I use the "kodi.koinos" TikZ library

  Scenario Outline: verifying the macro does trim leading spaces
    Given the body is
    """
    \newtoks\toks
    \toks{<code>}
    \message{the input token list: [\the\toks]}
    \kDTrimLeadingSpace\toks
    \message{the output token list: [\the\toks]}
    """
    Then compilation succeeds
    And the log includes the input token list: [<input toks>]
    And the log includes the output token list: [<output toks>]

    Examples:
      | code     | input toks | output toks |
      | «»       | «»         | «»          |
      | « »      | « »        | «»          |
      | «  »     | « »        | «»          |
      | «foo»    | «foo»      | «foo»       |
      | « foo»   | « foo»     | «foo»       |
      | «  foo»  | « foo»     | «foo»       |
      | «\foo»   | «\foo »    | «\foo »     |
      | « \foo»  | « \foo »   | «\foo »     |
      | «  \foo» | « \foo »   | «\foo »     |
