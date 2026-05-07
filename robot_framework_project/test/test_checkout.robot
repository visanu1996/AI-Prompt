*** Settings ***
Documentation    Checkout feature tests for SauceDemo application.
Resource         ${CURDIR}/../../init.resource

Suite Setup      Create Web Driver
Suite Teardown   Close Browser
Test Setup    Run Keywords    
...                   Create Browser Context     
...            AND    Open Web
...            AND    Login As Standard User
Test Teardown    Close Context

*** Test Cases ***
Complete Purchase Successfully
    [Documentation]    Verifies complete purchase flow from cart to order confirmation.
    Verify Inventory Page Displayed
    Add Product To Cart    Sauce Labs Backpack
    Navigate To Cart
    Verify Cart Page Displayed
    Proceed To Checkout
    Fill Checkout Information    John    Doe    12345
    Continue Checkout
    Verify Checkout Overview Displayed
    Finish Checkout
    Verify Order Confirmation

Checkout With Missing First Name
    [Documentation]    Verifies error when first name is missing.
    
    Open Web
    Login As Standard User
    Verify Inventory Page Displayed
    Add Product To Cart    Sauce Labs Backpack
    Navigate To Cart
    Proceed To Checkout
    Fill Checkout Information    ${EMPTY}    Doe    12345
    Continue Checkout
    Verify Checkout Error    First Name is required

Checkout With Missing Last Name
    [Documentation]    Verifies error when last name is missing.
    
    Open Web
    Login As Standard User
    Verify Inventory Page Displayed
    Add Product To Cart    Sauce Labs Backpack
    Navigate To Cart
    Proceed To Checkout
    Fill Checkout Information    John    ${EMPTY}    12345
    Continue Checkout
    Verify Checkout Error    Last Name is required

Checkout With Missing Postal Code
    [Documentation]    Verifies error when postal code is missing.
    
    Open Web
    Login As Standard User
    Verify Inventory Page Displayed
    Add Product To Cart    Sauce Labs Backpack
    Navigate To Cart
    Proceed To Checkout
    Fill Checkout Information    John    Doe    ${EMPTY}
    Continue Checkout
    Verify Checkout Error    Postal Code is required

Cancel Checkout
    [Documentation]    Verifies cancellation RETURNs to cart.
    
    Open Web
    Login As Standard User
    Verify Inventory Page Displayed
    Add Product To Cart    Sauce Labs Backpack
    Navigate To Cart
    Proceed To Checkout
    Cancel Checkout
    Verify Cart Page Displayed
