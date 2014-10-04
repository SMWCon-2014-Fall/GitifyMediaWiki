Feature: Gitify MediaWiki

  This file represents an initial set of examples for expected behaviour.
  See https://github.com/SMWCon-2014-Fall/GitifyMediaWiki/wiki for more thoughts on this.

  Next steps include populating the features/ directory with more examples about expected
  behaviour.

  Background: Clone a MediaWiki to Sylvester's notebook

    Given there is a MediaWiki at "https://wiki.2010.org"
    And user "Sylvester" runs "clone https://wiki.2010.org" on his notebook
    Then he can access the clone at "localhost/wiki.2010.org"
    Given user "Tweety" edits the page "January" on https://wiki.2010.org adding the content
      "== Desert ==\n\nMy desert edit."
    And user "Sylvester" edits the page "January" on localhost/wiki.2010.org adding the content
      "== Sea ==\n\nMy sea edit."
    And user "Sylvester" runs "sync localhost/wiki.2010.org" on his notebook

  Scenario: Half-duplex synchronization

    Then both clones "https://wiki.2010.org" and "localhost/wiki.2010.org" must merge the content and
      history for the page "January" inserting the templates "== Desert {{edited_by|Tweety}} =="
      and "== Sea {{edited_by|Sylvester}} =="
    And the page should contain the template "{{review_distributed_edits}}"
    And users "Tweety, Sylvester" should see an alert "{{review_distributed_edits|January}}" on
      their watchlist pages.

  Scenario: Simplex synchronization

    Then only the clone "localhost/wiki.2010.org" must merge the content and
      history for the page "January" inserting the templates "== Desert {{edited_by|Tweety}} =="
      and "== Sea {{edited_by|Sylvester}} =="
    And the page should contain the template "{{review_distributed_edits}}"
    And users "Sylvester" should see an alert "{{review_distributed_edits|January}}" on their watchlist pages.
