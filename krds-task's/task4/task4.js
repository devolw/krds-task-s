const orders = [
    {
        id: 1,
        status: 'delivered',
        deliveryDate: '2024-10-05',
        items: [
            { productName: 'Item1', quantity: 2, price: 50 },
            { productName: 'Item2', quantity: 1, price: 100 }
        ]
    },
    {
        id: 2,
        status: 'pending',
        deliveryDate: '2024-10-12',
        items: [
            { productName: 'Item3', quantity: 1, price: 200 }
        ]
    },
    {
        id: 3,
        status: 'delivered',
        deliveryDate: '2024-10-15',
        items: [
            { productName: 'Item4', quantity: 2, price: 45 },
            { productName: 'Item5', quantity: 1, price: 90 }
        ]
    },
    {
        id: 4,
        status: 'delivered',
        deliveryDate: '2024-10-22',
        items: [
            { productName: 'Item6', quantity: 2, price: 80 },
            { productName: 'Item7', quantity: 1, price: 200 },
            { productName: 'Item8', quantity: 4, price: 120 }
        ]
    },
    {
        id: 5,
        status: 'pending',
        deliveryDate: '2024-11-05',
        items: [
            { productName: 'Item9', quantity: 4, price: 120 }
        ]
    },
    {
        id: 6,
        status: 'delivered',
        deliveryDate: '2024-11-15',
        items: [
            { productName: 'Item10', quantity: 3, price: 30 },
            { productName: 'Item11', quantity: 1, price: 150 }
        ]
    },
    {
        id: 7,
        status: 'delivered',
        deliveryDate: '2024-11-20',
        items: [
            { productName: 'Item12', quantity: 4, price: 75 },
            { productName: 'Item13', quantity: 2, price: 60 },
            { productName: 'Item14', quantity: 3, price: 90 },
            { productName: 'Item15', quantity: 1, price: 175 }
        ]
    },
    {
        id: 8,
        status: 'delivered',
        deliveryDate: '2024-11-25',
        items: [
            { productName: 'Item16', quantity: 1, price: 300 }
        ]
    },
    {
        id: 9,
        status: 'delivered',
        deliveryDate: '2024-12-01',
        items: [
            { productName: 'Item17', quantity: 5, price: 60 },
            { productName: 'Item18', quantity: 2, price: 120 }
        ]
    },
    {
        id: 10,
        status: 'pending',
        deliveryDate: '2024-12-10',
        items: [
            { productName: 'Item19', quantity: 3, price: 150 }
        ]
    }
];

function sumOrdersByMonth(orders) {
    return orders
        .filter(order => order.status === 'delivered') // Фильтруем заказы с статусом "delivered"
        .reduce((acc, order) => {
            // Подсчитываем общую стоимость всех товаров в каждом заказе
            const totalCost = order.items.reduce((sum, item) => sum + item.price * item.quantity, 0);
            
            // Получаем месяц доставки
            const deliveryMonth = new Date(order.deliveryDate).toLocaleString('en-US', { month: 'long' });

            // Группируем по месяцам доставки
            if (!acc[deliveryMonth]) {
                acc[deliveryMonth] = 0;
            }

            // Добавляем стоимость заказа в месяц
            acc[deliveryMonth] += totalCost;

            return acc;
        }, {});
}

// Вызов функции
const sumOrders = sumOrdersByMonth(orders);
console.log(sumOrders);