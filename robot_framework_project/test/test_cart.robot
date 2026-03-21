*** Settings ***
Documentation    Cart feature tests for SauceDemo application.
Resource         ${CURDIR}/../../init.resource

Suite Setup      Create Web Driver
Suite Teardown   Close Browser
Test Setup    Run Keywords    
...                   Create Browser Context     
...            AND    Open Web
...            AND    Login As Standard User
Test Teardown    Close Context

*** Test Cases ***
View Cart With Items
    [Documentation]    Verifies cart displays added items.
    Verify Inventory Page Displayed
    Add Product To Cart    Sauce Labs Backpack
    Navigate To Cart
    Verify Cart Page Displayed
    ${item_count}=    Get Cart Item Count
    Should Be Equal    ${item_count}    1    msg=Expected 1 item in cart

View Empty Cart
    [Documentation]    Verifies empty cart displays correctly.
    Verify Inventory Page Displayed
    Navigate To Cart
    Verify Cart Is Empty

Continue Shopping From Cart
    [Documentation]    Verifies navigation back to inventory from cart.
    Verify Inventory Page Displayed
    Add Product To Cart    Sauce Labs Backpack
    Navigate To Cart
    Continue Shopping
    Verify Inventory Page Displayed

Remove Item From Cart Page
    [Documentation]    Verifies removing item from cart page.
    Verify Inventory Page Displayed
    Add Product To Cart    Sauce Labs Backpack    Sauce Labs Bike Light
    Navigate To Cart
    ${initial_count}=    Get Cart Item Count
    Remove Item From Cart    0
    ${final_count}=    Get Cart Item Count
    Should Be True    ${final_count} < ${initial_count}    msg=Item was not removed

Proceed To Checkout From Cart
    [Documentation]    Verifies checkout button functionality from cart.
    Verify Inventory Page Displayed
    Add Product To Cart    Sauce Labs Backpack
    Navigate To Cart
    Verify Cart Page Displayed
    Proceed To Checkout

