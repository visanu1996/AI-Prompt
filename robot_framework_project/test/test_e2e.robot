*** Settings ***
Documentation    End-to-end workflow tests for SauceDemo application.
Resource         ${CURDIR}/../../init.resource

Suite Setup      Create Web Driver
Suite Teardown   Close Browser
Test Setup       Create Browser Context
Test Teardown    Close Context

*** Test Cases ***
Complete E2E Shopping Workflow
    [Documentation]    Full end-to-end workflow from login to order confirmation.
    
    Open Web
    
    # Login
    Verify Login Page Displayed
    Login As Standard User
    Verify Inventory Page Displayed
    
    # Add Products to Cart
    Add Product To Cart    Sauce Labs Backpack
    Add Product To Cart    Sauce Labs Bike Light
    Check Cart Badge    2
    
    # View Cart
    Navigate To Cart
    Verify Cart Page Displayed
    ${item_count}=    Get Cart Item Count
    Should Be Equal    ${item_count}    2
    
    # Proceed to Checkout
    Proceed To Checkout
    Fill Checkout Information    Jane    Smith    54321
    Continue Checkout
    Verify Checkout Overview Displayed
    
    # Complete Order
    Finish Checkout
    Verify Order Confirmation

E2E Add Remove Items Workflow
    [Documentation]    Workflow to add, remove, and manage cart items.
    
    Open Web
    Login As Standard User
    Verify Inventory Page Displayed
    
    # Add multiple items
    Add Product To Cart    Sauce Labs Backpack
    Add Product To Cart    Sauce Labs Bike Light
    Add Product To Cart    Sauce Labs Bolt T-Shirt
    Check Cart Badge    3
    
    # Navigate and verify cart
    Navigate To Cart
    ${initial_count}=    Get Cart Item Count
    Should Be Equal    ${initial_count}    3
    
    # Remove item and verify
    Remove Item From Cart    0
    ${updated_count}=    Get Cart Item Count
    Should Be Equal    ${updated_count}    2
    
    # Continue shopping
    Continue Shopping
    Verify Inventory Page Displayed

E2E Logout Workflow
    [Documentation]    Workflow to verify logout functionality.
    
    Open Web
    Login As Standard User
    Verify Inventory Page Displayed
    Logout From App
    Verify Login Page Displayed
    
    # Verify can login again
    Login As Standard User
    Verify Inventory Page Displayed
