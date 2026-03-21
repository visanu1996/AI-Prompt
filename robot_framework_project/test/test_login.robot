*** Settings ***
Documentation    Login feature tests for SauceDemo application.
Resource         ${CURDIR}/../../init.resource

Suite Setup      Create Web Driver
Suite Teardown   Close Browser
Test Setup       Create Browser Context
Test Teardown    Close Context

*** Test Cases ***
Login With Valid Credentials
    [Documentation]    Verifies successful login with standard user.
    
    Open Web
    Verify Login Page Displayed
    Login As Standard User
    Verify Inventory Page Displayed

Login With Locked Out User
    [Documentation]    Verifies locked out user receives appropriate error.
    
    Open Web
    Verify Login Page Displayed
    Login As Locked Out User
    Verify Login Error Message    Epic sadface: Sorry, this user has been locked out.

Login With Invalid Credentials
    [Documentation]    Verifies invalid credentials produce error message.
    
    Open Web
    Verify Login Page Displayed
    Login With Credentials    invalid_user    invalid_password
    Verify Login Error Message    ${messages.login_error}

Login With Empty Username
    [Documentation]    Verifies empty username produces error message.
    
    Open Web
    Verify Login Page Displayed
    Login With Credentials    ${EMPTY}    secret_sauce
    Verify Login Error Message    Epic sadface: Username is required

Login With Empty Password
    [Documentation]    Verifies empty password produces error message.
    
    Open Web
    Verify Login Page Displayed
    Login With Credentials    standard_user    ${EMPTY}
    Verify Login Error Message    Epic sadface: Password is required

Logout After Login
    [Documentation]    Verifies successful logout after login.
    
    Open Web
    Login As Standard User
    Verify Inventory Page Displayed
    Logout From App
    Verify Login Page Displayed
