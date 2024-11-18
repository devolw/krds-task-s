const { Pool } = require('pg');

(async () => {
    const pool = new Pool({
        host: 'localhost',
        user: 'popoff',
        password: '0703Kanji',
        database: 'task1',
        port: 5432,
    });

    try {
        console.log('Подключение установлено.');

        const deleteDuplicates = `
            DELETE FROM a
            WHERE ctid NOT IN (
                SELECT MIN(ctid)
                FROM a
                GROUP BY b, c, d
            );
        `;

        const result = await pool.query(deleteDuplicates);
        console.log(`Дубли удалены. Количество удаленных строк: ${result.rowCount}`);
    } catch (error) {
        console.error('Ошибка при выполнении операции:', error.message);
    } finally {
        await pool.end();
        console.log('Соединение закрыто.');
    }
})();