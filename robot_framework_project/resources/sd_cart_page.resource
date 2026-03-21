*** Settings ***
Documentation    Page Object for SauceDemo Shopping Cart page.
...              Contains locators and actions for cart management.

*** Variables ***
# --- Locators ---
${CART_CONTAINER}           css=[id="cart_contents_container"]
${CART_ITEM}                css=[class="cart_item"]
${CART_ITEM_NAME}           css=[class="inventory_item_name"]
${CART_ITEM_PRICE}          css=[class="inventory_item_price"]
${CART_ITEM_QUANTITY}       css=[class="cart_quantity"]
${REMOVE_BUTTON}            css=[id*="remove"]
${CONTINUE_SHOPPING_BUTTON}  css=[id="continue-shopping"]
${CHECKOUT_BUTTON}          css=[id="checkout"]
${CART_SUBTOTAL}            css=[class="subtotal_label"]
${CART_TAX}                 css=[class="tax_label"]
${CART_TOTAL}               css=[class="total_label"]

*** Keywords ***
Verify Cart Page Displayed
    [Documentation]    Verifies the cart page is loaded.
    Verify Element Visible    ${CART_CONTAINER}

Get Cart Item Count
    [Documentation]    RETURNs the number of items in the cart.
    ${items}=    Get Elements    ${CART_ITEM}
    ${count}=    Get Length    ${items}
    RETURN     ${{str($count)}}

Remove Item From Cart
    [Arguments]    ${item_index}
    [Documentation]    Removes an item from cart by index.
    ${remove_buttons}=    Get Elements    ${REMOVE_BUTTON}
    Click    ${remove_buttons}[${item_index}]

Continue Shopping
    [Documentation]    Clicks the continue shopping button.
    Click    ${CONTINUE_SHOPPING_BUTTON}

Proceed To Checkout
    [Documentation]    Clicks the checkout button.
    Click    ${CHECKOUT_BUTTON}

Verify Cart Is Empty
    [Documentation]    Verifies the cart has no items.
    ${is_item_count_visible}    Run Keyword And Return Status    Wait For Elements State    ${CART_ITEM}    visible    timeout=5s
    IF    ${is_item_count_visible}    Fail    msg=Product is still visible (verify cart empty)
