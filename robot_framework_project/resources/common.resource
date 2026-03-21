*** Settings ***
Documentation    Global, app-agnostic keywords for common automation tasks.
Library    Browser
*** Keywords ***
Create Web Driver
    [Documentation]    Initializes browser with configured settings and Creates a new browser context with viewport settings.
    New Browser        browser=${browser}    headless=${headless}    args=['--start-maximized']    slowMo=1

Open Web
    [Documentation]    Opens the base URL in a new page.
    New Page           ${base_url}    wait_until=load

Verify Element Visible
    [Arguments]    ${locator}    ${timeout}=${global_timeout}
    [Documentation]    Verifies that an element is visible.
    Wait For Elements State    ${locator}    visible    timeout=${timeout}

Create Browser Context
    [Documentation]    Creates a new browser context with viewport settings.
    IF    not ${is_record}
    ${context}    New Context        viewport=${None}
    ELSE
    ${context}    New Context        viewport={'width': 1280, 'height': 720}   recordVideo={"dir": "./videos"}
    END
    RETURN    ${context}

Close Context
    [Documentation]    Closes the current browser context if ${context_name} is not None.
    [Arguments]    ${context_name}=${None}
    IF    ${context_name} != ${None}
        Browser.Close Context    context=${context_name}
    ELSE
        Browser.Close Context     CURRENT
    END  


