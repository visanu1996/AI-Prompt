*** Settings ***
Documentation    Page Object for SauceDemo Inventory/Products page.
...              Contains locators and actions for product listing and filtering.

*** Variables ***
# --- Locators ---
${PRODUCT_PAGE_HEADER}    //span[text()='Products']

&{ITEMS}    item_inventory=//div[@class='inventory_item_description' and .//div[@class='inventory_item_name ' and contains(text(),'[TO_CHANGE]')]]
...         product_name=//div[@class='inventory_item_name ']
...         product_desc=//div[@class='inventory_item_desc']
...         product_price=//div[@class='inventory_item_price']
...         product_add_btn=//button[contains(@id,'add-to-cart')]
...         product_remove_btn=//button[contains(@id,'remove')]

${PRODUCT_COUNT}    //a[@class='shopping_cart_badge']
${SORT_DROPDOWN}    css=[data-test="product_sort_container"]
${CART_BADGE}       css=[class="shopping_cart_badge"]

*** Keywords ***
Verify Inventory Page Displayed
    [Documentation]    Verifies the inventory page is loaded.
    Verify Element Visible    ${PRODUCT_PAGE_HEADER}

Add Product To Cart
    [Arguments]    @{products}
    [Documentation]    Add a products to cart by contains name.
    VAR    &{items_detail}
    FOR    ${product}    IN    @{products}
        VAR    ${product_card}    ${{$ITEMS['item_inventory'].replace('[TO_CHANGE]',$product)}}
        ${product_name}    Get Text    ${product_card}${ITEMS['product_name']}
        ${product_desc}    Get Text    ${product_card}${ITEMS['product_desc']}
        ${product_price}    Get Text    ${product_card}${ITEMS['product_price']}
        
        ${dict_detail}    Create Dictionary    desc=${product_desc}    price=${product_price}
        ${items_detail}['${{$product_name.lower()}}']=    Set Variable    ${dict_detail}
        
        Click    ${product_card}${ITEMS['product_add_btn']}
    END

Remove Product From Cart
    [Arguments]    @{products}
    [Documentation]    Removes a product from cart by contains name.
    VAR    &{items_detail}
    FOR    ${product}    IN    @{products}
        VAR    ${product_card}    ${{$ITEMS['item_inventory'].replace('[TO_CHANGE]',$product)}}
        ${product_name}    Get Text    ${product_card}${ITEMS['product_name']}
        ${product_desc}    Get Text    ${product_card}${ITEMS['product_desc']}
        ${product_price}    Get Text    ${product_card}${ITEMS['product_price']}
        
        ${dict_detail}    Create Dictionary    desc=${product_desc}    price=${product_price}
        ${items_detail}[${product_name}]    Set Variable    desc=${dict_detail}
        
        Click    ${product_card}${ITEMS['product_remove_btn']}
    END

Sort Products By
    [Arguments]    ${sort_option}
    [Documentation]    Sorts products by value.
    ...
    ...        [az, za, lohi, hilo]

    Select Options By    ${SORT_DROPDOWN}    value    ${sort_option}

Get Product Count
    [Documentation]    RETURNs the number of products displayed.
    ${count}    Get Text    ${PRODUCT_COUNT}
    Log    ${count}
    RETURN        ${count}

Check Cart Badge
    [Arguments]    ${expected_count}
    [Documentation]    Verifies the cart badge displays the expected item count.
    ${badge_text}=    Get Text    ${CART_BADGE}
    Should Be Equal    ${badge_text}    ${expected_count}    msg=Cart badge count mismatch

Badge Should Not Be Invisible
    [Documentation]    Verifies the cart badge to not be displays.
    ${is_badge_visible}    Run Keyword And Return Status    Verify Element Visible    ${CART_BADGE}
    IF    ${is_badge_visible}    Fail    msg=Badge should not be visible.