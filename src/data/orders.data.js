const { status } = require("express/lib/response");

const orders = [

    {
        id: 1,
        userId: 1,
        productId: 4,
        quantity: 1,
        totalPrice: 109.99,
        status: "delivered",
        orderedAt: "2024-06-01"
    },

    {
        id: 2,
        userId: 2,
        productId: 1,
        quantity: 2,
        totalPrice: 119.98,
        status: "shipped",
        orderedAt: "2024-06-05"
    },

    {
        id: 3,
        userId: 3,
        productId: 1,
        quantity: 1,
        totalPrice: 89.99,
        status: "processing",
        orderedAt: "2024-06-10"
    },

    {
        id: 4,
        userId: 5,
        productId: 6,
        quantity: 3,
        totalPrice: 89.97,
        status: "delivered",
        orderedAt: "2024-06-12"
    },

    {
        id: 5,
        userId: 4,
        productId: 3,
        quantity: 2,
        totalPrice: 79.98,
        status: "pending",
        orderedAt: "2024-06-15"
    }
];

module.exports = orders;