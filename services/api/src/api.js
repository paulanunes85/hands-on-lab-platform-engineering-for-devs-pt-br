const crypto = require('crypto');
const { app, output } = require('@azure/functions');

const serviceBusOutput = output.serviceBusQueue({
    queueName: '%SERVICEBUS_QUEUE%',
    connection: 'SB_ORDERS',
});

app.http('api', {
    methods: ['POST'],
    authLevel: 'anonymous',
    return: serviceBusOutput,
    handler: async (request, context) => {
        const id = crypto.randomUUID();
        context.log(`Processing order ${id}`);

        const order = await request.json();

        // Simple validation: ensure the order has items
        if (!Array.isArray(order.items) || !order.items.length) {
            throw new Error('Order must have at least one item');
        }

        // // Generate some random errors for testing
        // if (Math.random() < 0.1) {
        //     throw new Error('Random error');
        // }

        return {
            id,
            createdAt: new Date().toISOString(),
            ...order,
        };
    }
});
