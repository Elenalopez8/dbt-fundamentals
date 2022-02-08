-- Use a statement tab or Snowflake to inspect raw.stripe.payment - 
-- Create a stg_payments.sql model in models/staging/stripe
-- Create a fct_orders.sql (not stg_orders) model with the following fields.  Place this in the marts/core directory.
-- order_id
-- customer_id
-- amount (hint: this has to come from payments)

select
    id as payment_id,
    orderid as order_id,
    paymentmethod as payment_method,
    status,

    -- amount is stored in cents, convert it to dollars
    {{ cents_to_dollars('amount', 4) }} as amount,
    created as created_at

from {{ source('stripe', 'payment') }}
