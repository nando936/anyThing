# Backend Feature List

This document tracks the features for the backend of the SaaS application.

## **Order Management**
| **Feature**           | **Description**                                                             | **Priority** | **Status**       |
|-----------------------|---------------------------------------------------------------------------|--------------|------------------|
| Order Entry           | Create, update, and delete orders                                         | High         | Planned          |
| Archive Orders        | Move completed orders to archive                                         | Medium       | Planned          |
| Estimate Handling     | Save and query order estimates                                            | Medium       | Planned          |
| Import Orders         | Import orders from Cabinet Vision, Excel, and manual entries             | High         | Planned          |
| CAD Line Drawings     | Generate CAD line drawings or 3D models for clarity on orders            | High         | Planned          |
| 3D Model Resizing     | Resize saved 3D models to ordered specifications and provide download links | Medium       | Planned          |

## **Accounting Integration**
| **Feature**        | **Description**                                             | **Priority** | **Status**       |
|--------------------|-------------------------------------------------------------|--------------|------------------|
| Invoice Queries    | Query open invoices from accounting API                     | High         | Planned          |
| Save Estimates     | Save estimates from orders to accounting system             | High         | Planned          |

## **User Management**
| **Feature**           | **Description**                                              | **Priority** | **Status**       |
|-----------------------|--------------------------------------------------------------|--------------|------------------|
| User Authentication   | Login/signup with JWT-based tokens                          | High         | Planned          |
| Role-Based Access     | Different permissions for admin and regular users           | High         | Planned          |

## **Notifications**
| **Feature**           | **Description**                                              | **Priority** | **Status**       |
|-----------------------|--------------------------------------------------------------|--------------|------------------|
| Email Notifications   | Send email updates for order status                         | Low          | Planned          |
| Invoice Reminders     | Notify users about pending invoices                         | Medium       | Planned          |

## **Dynamic Request Handling**
| **Feature**              | **Description**                                              | **Priority** | **Status**       |
|--------------------------|--------------------------------------------------------------|--------------|------------------|
| Flexible API Requests    | Enable the FE to dynamically request operations across modules (e.g., order, accounting, drawing) | High         | Planned          |
| Context-Aware Responses  | Provide responses tailored to the FE's specific query without strict API hierarchies              | High         | Planned          |
| Multi-Module Interaction | Allow the FE to trigger workflows spanning multiple modules (e.g., save order, sync with accounting, generate drawing) | High         | Planned          |
