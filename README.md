# E-Commerce Database Project(SQL)
This is a simple **E-Commerce Database
Management System**created using SQL..
The project includes tables for **Users Products,
Orders, and Payments**, along with sample data and queries.

if can be used for learning:
Database creation CRUD operations(Create,
REad, Update, Delete)
Joins and relationship
Aggregate functions Real-world E-Commerce data handling

__

1. **Users**
   - Stores customer and admin data.
   - Columns: `user_id`, `name`, `email`, `password`, `role`, `created_at`, `updated_at`

2. **Products**
   - Contains details about the products listed on the platform.
   - Columns: `product_id`, `name`, `description`, `price`, `category_id`, `stock_quantity`, `created_at`, `updated_at`

3. **Categories**
   - Stores product categories.
   - Columns: `category_id`, `category_name`

4. **Orders**
   - Stores customer order data.
   - Columns: `order_id`, `user_id`, `order_date`, `status`, `total_amount`

5. **Order_Items**
   - Contains the products in each order.
   - Columns: `order_item_id`, `order_id`, `product_id`, `quantity`, `price`

6. **Payments**
   - Stores transaction data for order payments.
   - Columns: `payment_id`, `order_id`, `payment_date`, `amount`, `payment_method`, `payment_status`

7. **Shipping**
   - Stores information related to shipping for each order.
   - Columns: `shipping_id`, `order_id`, `shipping_address`, `shipping_status`, `shipped_date`, `delivery_date`

### Relationships

- A **user** can have many **orders**.
- An **order** can contain many **order items**.
- A **product** can belong to many **order items**.
- An **order** has one **payment** and one **shipping**.

## Setup Instructions

To set up the project on your local machine, follow these steps:

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/e-commerce-sql-project.git
   cd e-commerce-sql-project
