### Trackpot: Feature Requirements

#### 1. User Profile Management
- **User Registration & Profile Update:**
  - Users can register and update their profile with the following details:
    - **First Name** (Required)
    - **Last Name**
    - **Email** (Required)
    - **Phone Number**
    - **Username** (Required)
    - **Location**
    - **Preferred Currency**
    - **Profile Picture**

#### 2. Group Management
- **Group Creation:**
  - Users can create groups.
- **Group Membership Management:**
  - Users can add or remove other users to/from a group.

#### 3. Expense Management
- **Add, Update, or Delete Expenses:**
  - Users in a group can add, modify, or remove expenses within the group.
  - **Expense Metadata:**
    - **Description:** A brief description of the expense.
    - **Expense Type:** Category of the expense (e.g., Food, Travel).
    - **Currency:** The currency in which the expense is recorded.
    - **Total Amount:** Total amount of the expense.
    - **Pay:** A list detailing who paid, and how much (List of [User, Amount]).
    - **Split Type:** Indicates if the split is equal or unequal.
    - **Splits:** List detailing how much each user owes (List of [User, Amount]).
    - **Expense Media:** Option to attach receipts or other related media.
    - **Notes:** Any additional notes related to the expense.

#### 4. Group Balance and Totals
- **View Group Balance:**
  - Users can view the balance details and total amounts for the group.
  
#### 5. User’s Overall Balance
- **View Personal Balance:**
  - Users can view their overall balance across all groups.

#### 6. Payment Management
- **Add, Update, or Delete Payments:**
  - Users can add, modify, or remove payments made against a balance.
  - **Payment Metadata:**
    - **Paid By:** The user who made the payment.
    - **Paid To:** The user who received the payment.
    - **Total Amount:** The total amount paid.
    - **Description:** A brief description of the payment.
    - **Payment Details Media:** Attachments related to the payment (e.g., screenshots of transactions).
    - **Payment Method:** The method of payment (e.g., cash, bank transfer).
    - **Notes:** Additional details about the payment.

#### 7. Group Activity Tracking
- **View Activity Logs:**
  - Users can see a history of all activities happening in the groups they are part of (e.g., expenses added, payments made, users added/removed).

#### 8. Notifications
- **Real-time Notifications:**
  - Users receive notifications for the following events:
    - When an expense involving the user is added, updated, or deleted.
    - When the user is added or removed from a group.
    - When a payment involving the user is added, updated, or removed.
    - When a group the user is part of is settled or deleted.
