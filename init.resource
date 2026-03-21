*** Settings ***
Documentation    Initialization resource for all Robot Framework tests.
...              Imports libraries and common resources.

Library          Browser
Library          Collections
Library          String

Resource         ${CURDIR}/robot_framework_project/resources/common.resource
Resource         ${CURDIR}/robot_framework_project/resources/sd_common.resource
Resource         ${CURDIR}/robot_framework_project/resources/sd_login_page.resource
Resource         ${CURDIR}/robot_framework_project/resources/sd_inventory_page.resource
Resource         ${CURDIR}/robot_framework_project/resources/sd_cart_page.resource
Resource         ${CURDIR}/robot_framework_project/resources/sd_checkout_page.resource

Variables        ${CURDIR}/robot_framework_project/config/config.yml
Variables        ${CURDIR}/robot_framework_project/config/test_data.yml
