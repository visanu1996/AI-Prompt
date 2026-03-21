*** Settings ***
Documentation    Page Object for SauceDemo Login page.
...              Contains locators and actions for the landing page.


*** Variables ***
# --- Locators ---
${LOGIN_USERNAME_INPUT}     id=user-name
${LOGIN_PASSWORD_INPUT}     id=password
${LOGIN_BUTTON}             id=login-button
${LOGIN_ERROR_CONTAINER}    //h3[@data-test='error']
${LOGIN_PAGE_LOGO}          //div[@class='login_logo']

*** Keywords ***
Login With Credentials
    [Arguments]    ${username}    ${password}
    [Documentation]    Inputs credentials and clicks login button.
    Wait For Elements State    ${LOGIN_USERNAME_INPUT}    visible    timeout=5s
    Fill Text                  ${LOGIN_USERNAME_INPUT}    ${username}
    Fill Secret                ${LOGIN_PASSWORD_INPUT}    $password
    Click                      ${LOGIN_BUTTON}

Verify Login Error Message
    [Arguments]    ${expected_message}
    [Documentation]    Checks if the error container shows the correct text.
    ${error_text}=    Get Text    ${LOGIN_ERROR_CONTAINER}
    Should Contain    ${error_text}    ${expected_message}

Verify Login Page Displayed
    [Documentation]    Verifies the login page is loaded.
    Verify Element Visible    ${LOGIN_PAGE_LOGO}

Clear Login Form
    [Documentation]    Clears both username and password fields.
    Fill Text    ${LOGIN_USERNAME_INPUT}    ${EMPTY}
    Fill Text    ${LOGIN_PASSWORD_INPUT}    ${EMPTY}
