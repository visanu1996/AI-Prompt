*** Settings ***
Documentation    Product inventory feature tests for SauceDemo application.
Resource         ${CURDIR}/../../init.resource

Suite Setup      Create Web Driver
Suite Teardown   Close Browser
Test Setup    Run Keywords    
...                   Create Browser Context     
...            AND    Open Web
...            AND    Login As Standard User
Test Teardown    Close Context

*** Test Cases ***
Add Product To Cart
    [Documentation]    Verifies adding a product to cart updates badge.
    Verify Inventory Page Displayed
    Add Product To Cart    Sauce Labs Backpack
    Check Cart Badge    1

Add Multiple Products To Cart
    [Documentation]    Verifies adding multiple products to cart.
    Verify Inventory Page Displayed
    Add Product To Cart    
    ...    Sauce Labs Backpack    
    ...    Sauce Labs Bike Light    
    ...    Bolt T-Shirt
    Check Cart Badge    3

Remove Product From Cart
    [Documentation]    Verifies removing a product from cart updates badge.
    Verify Inventory Page Displayed
    Add Product To Cart    Sauce Labs Backpack
    Check Cart Badge    1
    Remove Product From Cart    Sauce Labs Backpack
    Badge Should Not Be Visible

Navigate To Cart From Products
    [Documentation]    Verifies navigation to cart from inventory page.
    Verify Inventory Page Displayed
    Add Product To Cart    Sauce Labs Backpack
    Navigate To Cart
    Verify Cart Page Displayed
