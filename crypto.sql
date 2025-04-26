CREATE EXTENSION IF NOT EXISTS pgcrypto;

ALTER TABLE clubs ADD COLUMN IF NOT EXISTS contact_details_encrypted BYTEA;

-- Шифрование данных при вставке/обновлении
UPDATE clubs
SET contact_details_encrypted = pgp_sym_encrypt(
    'email: contact@example.com, phone: +79991234567', -- Исходные данные
    'мой-секретный-ключ' -- Ключ шифрования
)
WHERE club_id = 1;

UPDATE clubs
SET contact_details_encrypted = pgp_sym_encrypt(
    'email: chief@ironclub.ru',
    'мой-секретный-ключ'
)
WHERE club_id = 2;

-- Просмотр зашифрованных данных
SELECT club_id, club_name, contact_details_encrypted FROM clubs WHERE club_id IN (1, 2);


-- Дешифрование данных при чтении
SELECT
    club_id,
    club_name,
    pgp_sym_decrypt(contact_details_encrypted, 'мой-секретный-ключ') AS decrypted_details
FROM clubs
WHERE club_id = 1;