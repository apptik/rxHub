Feature: Common behaviour of RxHub

  Scenario Outline: Consumer subscription after subscribed to provider
    Given Hub"H" with ProxyType <proxyType>
    Given Provider"P"
    And Consumer"C"
    And Hub"H" is subscribed to Provider"P" with tag "T"
    When Consumer"C" subscribes to Hub"H" with tag "T"
    And Provider"P" emits Event"E"
    Then Consumer"C" should receive Event"E"

    Examples:
      | proxyType                            |
      | BehaviorSubjectProxy                 |
      | PublishSubjectProxy                  |
      | ReplaySubjectProxy                   |
      | BehaviorProcessorProxy               |
      | PublishProcessorProxy                |
      | ReplayProcessorProxy                 |
      | SafeBehaviorSubjectProxy             |
      | SafePublishSubjectProxy              |
      | SafeReplaySubjectProxy               |
      | SafeBehaviorProcessorProxy           |
      | SafePublishProcessorProxy            |
      | SafeReplayProcessorProxy             |
      | SerializedBehaviorSubjectProxy       |
      | SerializedPublishSubjectProxy        |
      | SerializedReplaySubjectProxy         |
      | SerializedBehaviorProcessorProxy     |
      | SerializedPublishProcessorProxy      |
      | SerializedReplayProcessorProxy       |
      | SafeSerializedBehaviorSubjectProxy   |
      | SafeSerializedPublishSubjectProxy    |
      | SafeSerializedReplaySubjectProxy     |
      | SafeSerializedBehaviorProcessorProxy |
      | SafeSerializedPublishProcessorProxy  |
      | SafeSerializedReplayProcessorProxy   |

  Scenario Outline: Consumer subscription before subscribed to provider
    Given Hub"H" with ProxyType <proxyType>
    Given Provider"P"
    And Consumer"C"
    And Consumer"C" is subscribed to Hub"H" with tag "T"
    When Hub"H" subscribes to Provider"P" with tag "T"
    And Provider"P" emits Event"E"
    Then Consumer"C" should receive Event"E"

    Examples:
      | proxyType                            |
      | BehaviorSubjectProxy                 |
      | PublishSubjectProxy                  |
      | ReplaySubjectProxy                   |
      | BehaviorProcessorProxy               |
      | PublishProcessorProxy                |
      | ReplayProcessorProxy                 |
      | SafeBehaviorSubjectProxy             |
      | SafePublishSubjectProxy              |
      | SafeReplaySubjectProxy               |
      | SafeBehaviorProcessorProxy           |
      | SafePublishProcessorProxy            |
      | SafeReplayProcessorProxy             |
      | SerializedBehaviorSubjectProxy       |
      | SerializedPublishSubjectProxy        |
      | SerializedReplaySubjectProxy         |
      | SerializedBehaviorProcessorProxy     |
      | SerializedPublishProcessorProxy      |
      | SerializedReplayProcessorProxy       |
      | SafeSerializedBehaviorSubjectProxy   |
      | SafeSerializedPublishSubjectProxy    |
      | SafeSerializedReplaySubjectProxy     |
      | SafeSerializedBehaviorProcessorProxy |
      | SafeSerializedPublishProcessorProxy  |
      | SafeSerializedReplayProcessorProxy   |

  Scenario Outline: 2 providers 1 consumer
    Given Hub"H" with ProxyType <proxyType>
    Given Provider"P1"
    And Provider"P2"
    And Consumer"C"
    And Hub"H" is subscribed to Provider"P1" with tag "T"
    And Hub"H" is subscribed to Provider"P2" with tag "T"
    And Consumer"C" is subscribed to Hub"H" with tag "T"
    When Provider"P1" emits Event"E1"
    And Provider"P2" emits Event"E2"
    Then Consumer"C" should receive Event"E1"
    And Consumer"C" should receive Event"E2"

    Examples:
      | proxyType                            |
      | BehaviorSubjectProxy                 |
      | PublishSubjectProxy                  |
      | ReplaySubjectProxy                   |
      | BehaviorProcessorProxy               |
      | PublishProcessorProxy                |
      | ReplayProcessorProxy                 |
      | SafeBehaviorSubjectProxy             |
      | SafePublishSubjectProxy              |
      | SafeReplaySubjectProxy               |
      | SafeBehaviorProcessorProxy           |
      | SafePublishProcessorProxy            |
      | SafeReplayProcessorProxy             |
      | SerializedBehaviorSubjectProxy       |
      | SerializedPublishSubjectProxy        |
      | SerializedReplaySubjectProxy         |
      | SerializedBehaviorProcessorProxy     |
      | SerializedPublishProcessorProxy      |
      | SerializedReplayProcessorProxy       |
      | SafeSerializedBehaviorSubjectProxy   |
      | SafeSerializedPublishSubjectProxy    |
      | SafeSerializedReplaySubjectProxy     |
      | SafeSerializedBehaviorProcessorProxy |
      | SafeSerializedPublishProcessorProxy  |
      | SafeSerializedReplayProcessorProxy   |

  Scenario Outline: 1 provider 2 consumers
    Given Hub"H" with ProxyType <proxyType>
    Given Provider"P"
    And Consumer"C1"
    And Consumer"C2"
    And Hub"H" is subscribed to Provider"P" with tag "T"
    And Consumer"C1" is subscribed to Hub"H" with tag "T"
    And Consumer"C2" is subscribed to Hub"H" with tag "T"
    When Provider"P" emits Event"E"
    Then Consumer"C1" should receive Event"E"
    And Consumer"C2" should receive Event"E"

    Examples:
      | proxyType                            |
      | BehaviorSubjectProxy                 |
      | PublishSubjectProxy                  |
      | ReplaySubjectProxy                   |
      | BehaviorProcessorProxy               |
      | PublishProcessorProxy                |
      | ReplayProcessorProxy                 |
      | SafeBehaviorSubjectProxy             |
      | SafePublishSubjectProxy              |
      | SafeReplaySubjectProxy               |
      | SafeBehaviorProcessorProxy           |
      | SafePublishProcessorProxy            |
      | SafeReplayProcessorProxy             |
      | SerializedBehaviorSubjectProxy       |
      | SerializedPublishSubjectProxy        |
      | SerializedReplaySubjectProxy         |
      | SerializedBehaviorProcessorProxy     |
      | SerializedPublishProcessorProxy      |
      | SerializedReplayProcessorProxy       |
      | SafeSerializedBehaviorSubjectProxy   |
      | SafeSerializedPublishSubjectProxy    |
      | SafeSerializedReplaySubjectProxy     |
      | SafeSerializedBehaviorProcessorProxy |
      | SafeSerializedPublishProcessorProxy  |
      | SafeSerializedReplayProcessorProxy   |

  Scenario Outline: 2 consumers + manual emit on the Proxy
    Given Hub"H" with ProxyType <proxyType>
    And Consumer"C1"
    And Consumer"C2"
    And Consumer"C1" is subscribed to Hub"H" with tag "T"
    And Consumer"C2" is subscribed to Hub"H" with tag "T"
    When Event"E" with tag "T" is emitted on Hub"H"
    Then Consumer"C1" should receive Event"E"
    And Consumer"C2" should receive Event"E"

    Examples:
      | proxyType                            |
      | BehaviorSubjectProxy                 |
      | PublishSubjectProxy                  |
      | ReplaySubjectProxy                   |
      | BehaviorProcessorProxy               |
      | PublishProcessorProxy                |
      | ReplayProcessorProxy                 |
      | SafeBehaviorSubjectProxy             |
      | SafePublishSubjectProxy              |
      | SafeReplaySubjectProxy               |
      | SafeBehaviorProcessorProxy           |
      | SafePublishProcessorProxy            |
      | SafeReplayProcessorProxy             |
      | SerializedBehaviorSubjectProxy       |
      | SerializedPublishSubjectProxy        |
      | SerializedReplaySubjectProxy         |
      | SerializedBehaviorProcessorProxy     |
      | SerializedPublishProcessorProxy      |
      | SerializedReplayProcessorProxy       |
      | SafeSerializedBehaviorSubjectProxy   |
      | SafeSerializedPublishSubjectProxy    |
      | SafeSerializedReplaySubjectProxy     |
      | SafeSerializedBehaviorProcessorProxy |
      | SafeSerializedPublishProcessorProxy  |
      | SafeSerializedReplayProcessorProxy   |

  Scenario Outline: Remove provider
    Given Hub"H" with ProxyType <proxyType>
    Given Provider"P"
    And Consumer"C"
    And Consumer"C" is subscribed to Hub"H" with tag "T"
    And Hub"H" is subscribed to Provider"P" with tag "T"
    When Provider"P" with tag "T" is removed from Hub"H"
    And Provider"P" emits Event"E"
    Then Consumer"C" should not receive Event"E"

    Examples:
      | proxyType                            |
      | BehaviorSubjectProxy                 |
      | PublishSubjectProxy                  |
      | ReplaySubjectProxy                   |
      | BehaviorProcessorProxy               |
      | PublishProcessorProxy                |
      | ReplayProcessorProxy                 |
      | SafeBehaviorSubjectProxy             |
      | SafePublishSubjectProxy              |
      | SafeReplaySubjectProxy               |
      | SafeBehaviorProcessorProxy           |
      | SafePublishProcessorProxy            |
      | SafeReplayProcessorProxy             |
      | SerializedBehaviorSubjectProxy       |
      | SerializedPublishSubjectProxy        |
      | SerializedReplaySubjectProxy         |
      | SerializedBehaviorProcessorProxy     |
      | SerializedPublishProcessorProxy      |
      | SerializedReplayProcessorProxy       |
      | SafeSerializedBehaviorSubjectProxy   |
      | SafeSerializedPublishSubjectProxy    |
      | SafeSerializedReplaySubjectProxy     |
      | SafeSerializedBehaviorProcessorProxy |
      | SafeSerializedPublishProcessorProxy  |
      | SafeSerializedReplayProcessorProxy   |


  Scenario Outline: Remove all providers
    Given Hub"H" with ProxyType <proxyType>
    Given Provider"P1"
    Given Provider"P2"
    And Consumer"C"
    And Consumer"C" is subscribed to Hub"H" with tag "T1"
    And Consumer"C" is subscribed to Hub"H" with tag "T2"
    And Hub"H" is subscribed to Provider"P1" with tag "T1"
    And Hub"H" is subscribed to Provider"P2" with tag "T2"
    When providers are cleared from Hub"H"
    And Provider"P1" emits Event"E1"
    And Provider"P2" emits Event"E2"
    Then Consumer"C" should not receive Event"E1"
    And Consumer"C" should not receive Event"E2"

    Examples:
      | proxyType                            |
      | BehaviorSubjectProxy                 |
      | PublishSubjectProxy                  |
      | ReplaySubjectProxy                   |
      | BehaviorProcessorProxy               |
      | PublishProcessorProxy                |
      | ReplayProcessorProxy                 |
      | SafeBehaviorSubjectProxy             |
      | SafePublishSubjectProxy              |
      | SafeReplaySubjectProxy               |
      | SafeBehaviorProcessorProxy           |
      | SafePublishProcessorProxy            |
      | SafeReplayProcessorProxy             |
      | SerializedBehaviorSubjectProxy       |
      | SerializedPublishSubjectProxy        |
      | SerializedReplaySubjectProxy         |
      | SerializedBehaviorProcessorProxy     |
      | SerializedPublishProcessorProxy      |
      | SerializedReplayProcessorProxy       |
      | SafeSerializedBehaviorSubjectProxy   |
      | SafeSerializedPublishSubjectProxy    |
      | SafeSerializedReplaySubjectProxy     |
      | SafeSerializedBehaviorProcessorProxy |
      | SafeSerializedPublishProcessorProxy  |
      | SafeSerializedReplayProcessorProxy   |


  Scenario Outline: Filtered Proxy Observable
    Given Hub"H" with ProxyType <proxyType>
    Given Provider"P"
    And Consumer"C1"
    And Consumer"C2"
    And Hub"H" is subscribed to Provider"P" with tag "T"
    And Consumer"C1" is subscribed to Hub"H" with tag "T" and filter"java.lang.String"
    And Consumer"C2" is subscribed to Hub"H" with tag "T" and filter"java.lang.Number"
    When Provider"P" emits Event"E"
    Then Consumer"C1" should receive Event"E"
    And Consumer"C2" should not receive Event"E"

    Examples:
      | proxyType                            |
      | BehaviorSubjectProxy                 |
      | PublishSubjectProxy                  |
      | ReplaySubjectProxy                   |
      | BehaviorProcessorProxy               |
      | PublishProcessorProxy                |
      | ReplayProcessorProxy                 |
      | SafeBehaviorSubjectProxy             |
      | SafePublishSubjectProxy              |
      | SafeReplaySubjectProxy               |
      | SafeBehaviorProcessorProxy           |
      | SafePublishProcessorProxy            |
      | SafeReplayProcessorProxy             |
      | SerializedBehaviorSubjectProxy       |
      | SerializedPublishSubjectProxy        |
      | SerializedReplaySubjectProxy         |
      | SerializedBehaviorProcessorProxy     |
      | SerializedPublishProcessorProxy      |
      | SerializedReplayProcessorProxy       |
      | SafeSerializedBehaviorSubjectProxy   |
      | SafeSerializedPublishSubjectProxy    |
      | SafeSerializedReplaySubjectProxy     |
      | SafeSerializedBehaviorProcessorProxy |
      | SafeSerializedPublishProcessorProxy  |
      | SafeSerializedReplayProcessorProxy   |

  Scenario Outline: Non manually Emittable Proxy
    And Hub"H" with ProxyType <proxyType> and Emittability "false"
    Given Provider"P"
    And Consumer"C1"
    And Consumer"C2"
    And Hub"H" is subscribed to Provider"P" with tag "T"
    And Consumer"C1" is subscribed to Hub"H" with tag "T" and filter"java.lang.String"
    And Consumer"C2" is subscribed to Hub"H" with tag "T" and filter"java.lang.Number"
    When Event"E" with tag "T" is emitted on Hub"H"
    Then Consumer"C1" should not receive Event"E"
    And Consumer"C2" should not receive Event"E"

    Examples:
      | proxyType                            |
      | BehaviorSubjectProxy                 |
      | PublishSubjectProxy                  |
      | ReplaySubjectProxy                   |
      | BehaviorProcessorProxy               |
      | PublishProcessorProxy                |
      | ReplayProcessorProxy                 |
      | SafeBehaviorSubjectProxy             |
      | SafePublishSubjectProxy              |
      | SafeReplaySubjectProxy               |
      | SafeBehaviorProcessorProxy           |
      | SafePublishProcessorProxy            |
      | SafeReplayProcessorProxy             |
      | SerializedBehaviorSubjectProxy       |
      | SerializedPublishSubjectProxy        |
      | SerializedReplaySubjectProxy         |
      | SerializedBehaviorProcessorProxy     |
      | SerializedPublishProcessorProxy      |
      | SerializedReplayProcessorProxy       |
      | SafeSerializedBehaviorSubjectProxy   |
      | SafeSerializedPublishSubjectProxy    |
      | SafeSerializedReplaySubjectProxy     |
      | SafeSerializedBehaviorProcessorProxy |
      | SafeSerializedPublishProcessorProxy  |
      | SafeSerializedReplayProcessorProxy   |