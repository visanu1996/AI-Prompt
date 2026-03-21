*** Settings ***
Documentation    Page Object for SauceDemo Checkout page.
...              Contains locators and actions for checkout process.


*** Variables ***
# --- Locators - Checkout Step One ---
${CHECKOUT_FIRST_NAME_INPUT}    css=[data-test="firstName"]
${CHECKOUT_LAST_NAME_INPUT}     css=[data-test="lastName"]
${CHECKOUT_POSTAL_CODE_INPUT}   css=[data-test="postalCode"]
${CHECKOUT_CONTINUE_BUTTON}     css=[id="continue"]
${CHECKOUT_CANCEL_BUTTON}       css=[id="cancel"]
${CHECKOUT_ERROR_CONTAINER}     css=[data-test="error"]

# --- Locators - Checkout Step Two ---
${CHECKOUT_OVERVIEW_CONTAINER}  css=[id="checkout_summary_container"]
${CHECKOUT_FINISH_BUTTON}       css=[id="finish"]

# --- Locators - Order Confirmation ---
${ORDER_CONFIRMATION_CONTAINER}    css=[id="checkout_complete_container"]
${CONFIRMATION_MESSAGE}         css=[class="complete-header"]

*** Keywords ***
Fill Checkout Information
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}
    [Documentation]    Fills in checkout form with customer information.
    Fill Text    ${CHECKOUT_FIRST_NAME_INPUT}    ${first_name}
    Fill Text    ${CHECKOUT_LAST_NAME_INPUT}    ${last_name}
    Fill Text    ${CHECKOUT_POSTAL_CODE_INPUT}    ${postal_code}

Continue Checkout
    [Documentation]    Clicks continue button to proceed to checkout step two.
    Click    ${CHECKOUT_CONTINUE_BUTTON}

Verify Checkout Overview Displayed
    [Documentation]    Verifies the checkout overview page is displayed.
    Verify Element Visible    ${CHECKOUT_OVERVIEW_CONTAINER}

Finish Checkout
    [Documentation]    Clicks finish button to complete the order.
    Click    ${CHECKOUT_FINISH_BUTTON}

Verify Order Confirmation
    [Documentation]    Verifies the order confirmation page is displayed.
    Verify Element Visible    ${ORDER_CONFIRMATION_CONTAINER}
    Verify Element Visible    ${CONFIRMATION_MESSAGE}

Verify Checkout Error
    [Arguments]    ${expected_error}
    [Documentation]    Verifies that checkout error message is displayed.
    ${error_text}=    Get Text    ${CHECKOUT_ERROR_CONTAINER}
    Should Contain    ${error_text}    ${expected_error}

Cancel Checkout
    [Documentation]    Clicks cancel button to abort checkout.
    Click    ${CHECKOUT_CANCEL_BUTTON}
