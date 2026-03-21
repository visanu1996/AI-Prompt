*** Settings ***
Documentation    SauceDemo-specific shared logic and common keywords.


*** Variables ***
${HAMBURGER_MENU}           css=[id="react-burger-menu-btn"]
${LOGOUT_LINK}              css=[id="logout_sidebar_link"]
${CART_ICON}                css=[id="shopping_cart_container"]

*** Keywords ***
Login As Standard User
    [Documentation]    Logs in with standard user credentials.
    Login With Credentials    ${users.standard.username}    ${users.standard.password}

Login As Locked Out User
    [Documentation]    Logs in with locked out user credentials.
    Login With Credentials    ${users.locked.username}    ${users.locked.password}

Login As Problem User
    [Documentation]    Logs in with problem user credentials.
    Login With Credentials    ${users.problem.username}    ${users.problem.password}

Logout From App
    [Documentation]    Opens menu and clicks logout.
    Click    ${HAMBURGER_MENU}
    Click    ${LOGOUT_LINK}

Navigate To Cart
    [Documentation]    Clicks the cart icon to navigate to cart page.
    Click    ${CART_ICON}
